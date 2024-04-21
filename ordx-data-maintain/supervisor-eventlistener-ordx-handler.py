#!/usr/bin/env python
from datetime import datetime
import shlex
import sys
import subprocess  # Added for calling an external bash script

def write_stdout(s):
    sys.stdout.write(s)
    sys.stdout.flush()

def write_stderr(s):
    sys.stderr.write(s)
    sys.stderr.flush()

def run_command(command):
    try:
        result = subprocess.run(
            command,
            stderr=subprocess.PIPE,
            text=True  # This makes the output to be str, not bytes
        )
        if result.stderr:
            write_stderr('STDERR: {}\n'.format(result.stderr))
    except Exception as e:
        write_stderr('An error occurred: {}\n'.format(e))
        
def main():
    while True:
        write_stdout('READY\n')
        line = sys.stdin.readline()
        write_stderr("line: " + line + "\n")
        headers = dict([x.split(':') for x in line.split()])
        data = sys.stdin.read(int(headers['len']))
        payload = dict([x.split(':') for x in data.split()])
        if payload.get('expected', '0') == '0':
            processname = payload.get('processname')     
            write_stderr("processname: " + processname + "\n")
            if processname == 'ordx-server-master-testnet':
                write_stderr("run command b2r.sh" + "\n")
                run_command([
                    "/root/ordx-data-maintain/b2r.sh",
                    "-m", "recover",
                    "-c", "testnet",
                    "-i", "basic",
                    "-d", "/data2/ordxData",
                    "-b", "/data2/ordxData-backup",
                    "-o", "latest"
                ])
                write_stderr("run command supervisorctl\n")
                run_command(['supervisorctl', 'start', 'ordx-server-master-testnet'])
                current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                write_stderr("processname resume data and program is success, current_time: " + current_time + "\n")
            elif processname == 'ordx-server-master-main':
                write_stderr("run command b2r.sh" + "\n")
                run_command([
                    "/root/ordx-data-maintain/b2r.sh",
                    "-m", "recover",
                    "-c", "mainnet",
                    "-i", "basic",
                    "-d", "/data2/ordxData",
                    "-b", "/data2/ordxData-backup",
                    "-o", "latest"
                ])
                write_stderr("run command supervisorctl\n")
                run_command(['supervisorctl', 'start', 'ordx-server-master-main'])
                current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                write_stderr("processname resume data and program is success, current_time: " + current_time + "\n")
        write_stdout('RESULT 2\nOK')

if __name__ == '__main__':
    main()