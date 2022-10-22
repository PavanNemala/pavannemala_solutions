'''
1-3. Setup a python script that connects to remote servers over ssh and does the following
     a. Accept commands to be executed on all the remote machines at once
     b. Wait for the execution to be completed on all the remote machines.Accept next input only once the previous execution is completed on all the machines (failed/successful)
     
I am assuming all servers having ssh connetion with key authentication. 

Reason for solution: Using python paramiko module to ssh and processpool executor for parallel processing.
'''

import paramiko
from concurrent.futures import ProcessPoolExecutor
from itertools import repeat


list_of_hosts = ["host1","host2","host3","host4","host5","host6","host7","host8","host9"]

def execute_command(command,ip):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        client.connect(ip.strip(), port=22, timeout=5)
    except Exception as msg:
        return "Connection Failed with:",msg,ip
    stdin, _, _ = client.exec_command(command.strip())
    client.close()
    return command,":successfully on host:",ip.strip()

def start_service():
    with ProcessPoolExecutor() as executor:
            while True:
                command = input("enter the command to execute:")
                for result in executor.map(execute_command, repeat(command), list_of_hosts):
                    print(result)

if __name__ == "__main__":
    start_service()