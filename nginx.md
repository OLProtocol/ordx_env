apt install openresty

vi /etc/openresty/nginx.conf

#user  nobody;
worker_processes  2;
worker_rlimit_nofile 400000;

error_log  logs/error.log;
error_log  logs/error.log  notice;
error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  65535;
}

vi /etc/openresty/sites-enabled/prd.ordx.space
lua_package_path "/usr/local/openresty/lualib/resty/?.lua;/usr/local/openresty/lualib/resty/upstream/?.lua;;";

upstream mainnet1 {
    server 127.0.0.1:8001;
    server 127.0.0.1:8003 backup;
}

upstream testnet1 {
    server 127.0.0.1:8002;
    server 127.0.0.1:8004 backup;
}


lua_shared_dict healthcheck 1m;
lua_socket_log_errors off;
init_worker_by_lua_block {
    local hc = require "resty.upstream.healthcheck"
    local ok, err = hc.spawn_checker {
        shm = "healthcheck",
        upstream = "mainnet1",
        type = "http",
        http_req = "GET /mainnet/health HTTP/1.0\r\nHost: mainnet1\r\n\r\n",
        interval = 30000,
        timeout = 5000,
        fall = 3,
        rise = 2,
        valid_statuses = {200, 302},
        concurrency = 1,
        -- ssl_verify = true, -- https type only, verify ssl certificate or not, default true
        -- host = mainnet, -- https type only, host name in ssl handshake, default nil
    }

    ok, err = hc.spawn_checker {
        shm = "healthcheck",
        upstream = "testnet1",
        type = "http",
        http_req = "GET /testnet/health HTTP/1.0\r\nHost: testnet1\r\n\r\n",
        interval = 30000,
        timeout = 5000,
        fall = 3,
        rise = 2,
        valid_statuses = {200, 302},
        concurrency = 1,
        -- ssl_verify = true, -- https type only, verify ssl certificate or not, default true
        -- host = testnet1, -- https type only, host name in ssl handshake, default nil
    }


    if not ok then
        ngx.log(ngx.ERR, "=======> failed to spawn health checker: ", err)
        return
    end
}

server {
    server_name apiprd.ordx.space; # managed by Certbot
    access_log logs/main.log combined;
    # status page for all the peers:
    location = /status {
        access_log on;
        allow 127.0.0.1;
        allow 103.103.245.177; # 本机
        allow 146.56.96.109;   # 公司大楼
        allow 183.47.45.170;   # 翻墙IP
        deny all; 


        default_type text/plain;
        content_by_lua_block {
            local hc = require "resty.upstream.healthcheck"
            ngx.say("Nginx Worker PID: ", ngx.worker.pid())
            ngx.print(hc.status_page())
        }
    }

    # status page for all the peers (prometheus format):
    location = /metrics {
        access_log on;
        default_type text/plain;
        content_by_lua_block {
            local hc = require "resty.upstream.healthcheck"
            st , err = hc.prometheus_status_page()
            if not st then
                ngx.say(err)
                return
            end
            ngx.print(st)
        }
    }

    location /mainnet {
        proxy_pass http://mainnet1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }


    location /testnet {
        proxy_pass http://testnet1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/ordx.space/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/ordx.space/privkey.pem; # managed by Certbot
    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;


tail -f /usr/local/openresty/nginx/logs/error.log
