#!/usr/bin/env python
import sys
import subprocess  # Added for calling an external bash script

def write_stdout(s):
    sys.stdout.write(s)
    sys.stdout.flush()

def write_stderr(s):
    sys.stderr.write(s)
    sys.stderr.flush()

def callBashScript(script):
    # Assuming you want to call a bash script with subprocess
    subprocess.call(script, shell=True)

def main():
    while True:
        write_stdout('READY\n')
        line = sys.stdin.readline()
        headers = dict([x.split(':') for x in line.split()])
        data = sys.stdin.read(int(headers['len']))
        payload = dict([x.split(':') for x in data.split()])
        if payload.get('expected', '0') == '0':  # Changed 0 to '0'
            processname = payload.get('processname')
            if processname == 'ordx-server-master-testnet':
                callBashScript("/root/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o latest")
            elif processname == 'ordx-server-master-mainnet':  # Fixed 'elseif' to 'elif'
                callBashScript("/root/ordx-data-maintain/b2r.sh -m recover -c mainnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o latest")
        write_stdout('RESULT 2\nOK')

if __name__ == '__main__':
    main()