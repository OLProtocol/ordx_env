```shell
# macos
## clean 
rm -rf /usr/local/etc/mecabrc
rm -rf /usr/local/etc/my.cnf.d
rm -rf /usr/local/etc/my.cnf
rm -rf /usr/local/var/mysql/*
rm /tmp/mysql.sock
brew uninstall mariadb
brew cleanup mariadb
## install 
brew install mariadb
## set root && config cmd
su root
passwd
exit
su root
mysql -uroot - p
select user,host,plugin from mysql.user; 
set password for 'root'@'localhost' = password('root');
grant all privileges on *.* to 'root'@'%' identified by 'root';
grant all privileges on *.* to 'root'@'localhost' identified by 'root';
grant all privileges on mempool.* to 'mempool'@'%' identified by 'mempool';
grant all privileges on mempool.* to 'mempool'@'localhost' identified by 'mempool';
flush privileges;

## config file
vi /usr/local/etc/my.cnf.d/50-server.cnf
[mysqld]
bind-address = 0.0.0.0
lower_case_table_names = 1
## common
brew services info/start/stop/restart mariadb
mysql.server start/stop
ps -axu |grep mysql
## sql cmd
show databases;
use mysql; 
show tables;
desc table;
create database `database_A`; 
drop database `database_A`;


# ubuntu
## clean
sudo apt-get remove mysql-*
rm /var/run/mysqld/mysqld.sock
## install
sudo apt update
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo systemctl start/enable mariadb
## config file
vi /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
bind-address = 0.0.0.0
lower_case_table_names = 1
systemctl restart mariadb.service
## config cmd
sudo mysql / sudo mariadb / mysql -uroot -p
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
grant all privileges on mempool.* to 'mempool'@'%' identified by 'mempool';
grant all privileges on mempool.* to 'mempool'@'localhost' identified by 'mempool';
FLUSH PRIVILEGES;
### lower_case_table_names
SHOW VARIABLES LIKE '%case%'; 
exit;
## common
sudo systemctl start/enable/stop/restart/status mariadb

```