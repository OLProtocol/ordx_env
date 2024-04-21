#!/usr/bin/env python
import sys

def write_stdout(s):
    sys.stdout.write(s)
    sys.stdout.flush()

def write_stderr(s):
    sys.stderr.write(s)
    sys.stderr.flush()

def main():
    while True:
        headers = sys.stdin.readline()
        if not headers:
            break
        print(headers)
        # 从事件头中读取并解析长度
        headers = dict([x.split(':') for x in headers.split()])
        data = sys.stdin.read(int(headers['len']))
        # 从事件数据中解析
        payload = dict([x.split(':') for x in data.split()])

        if headers['eventname'] == 'PROCESS_STATE_EXITED':
            if payload.get('expected', 0) == '0' and payload.get('processname', '') == 'your_program':
                # 进程非正常退出，做一些处理
                exitstatus = int(payload.get('exitstatus', 0))
                if exitstatus != 0:
                    # 执行你的脚本或命令
                    pass

        # 告诉Supervisor处理事件完成
        write_stdout('RESULT 2\nOK')

if __name__ == '__main__':
    main()