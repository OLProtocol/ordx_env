#!/usr/bin/env python
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
        result = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            # shell=True
        )
        stdout, stderr = result.communicate()
        write_stderr('STDOUT: {}\n'.format(stdout.decode()))
        write_stderr('STDERR: {}\n'.format(stderr.decode()))
    except Exception as e:
        write_stderr('An error occurred: {}\n'.format(e))
        
def main():
    while True:
        write_stdout('READY\n')
        line = sys.stdin.readline()
        headers = dict([x.split(':') for x in line.split()])
        data = sys.stdin.read(int(headers['len']))
        payload = dict([x.split(':') for x in data.split()])
        if payload.get('expected', '0') == '0':
            processname = payload.get('processname')     
            write_stderr("processname: " + processname)
            if processname == 'ordx-server-master-testnet':
                run_command([
                    "/root/ordx-data-maintain/b2r.sh",
                    "-m", "recover",
                    "-c", "testnet",
                    "-i", "basic",
                    "-d", "/data2/ordxData",
                    "-b", "/data2/ordxData-backup",
                    "-o", "latest"
                ])
                run_command(['supervisorctl', 'start', 'ordx-server-master-testnet'])
            elif processname == 'ordx-server-master-main':
                run_command([
                    "/root/ordx-data-maintain/b2r.sh",
                    "-m", "recover",
                    "-c", "mainnet",
                    "-i", "basic",
                    "-d", "/data2/ordxData",
                    "-b", "/data2/ordxData-backup",
                    "-o", "latest"
                ])
                run_command(['supervisorctl', 'start', 'ordx-server-master-main'])
        write_stdout('RESULT 2\nOK')

if __name__ == '__main__':
    main()