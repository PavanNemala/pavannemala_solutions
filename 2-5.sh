#!/bin/sh

: 'Shell script to take third most CPU & Memory consuming process, this should output to output file with the following properties
Process Name 
% CPU  used 
% Memory used  
PORT 
PID
'

echo "Process Name,CPU,Memory,PORT,PID" > result.txt
M_PROCESS=`ps -eo cmd,%mem,%cpu,pid --sort=-%mem |  awk 'NR==4 {print}'`
C_PROCESS=`ps -eo cmd,%mem,%cpu,pid --sort=-%cpu |  awk 'NR==4 {print}'`

PROCESS_ID=`echo $M_PROCESS| cut -d' ' -f4`
MEMORY=`echo $M_PROCESS| cut -d' ' -f2`
CPU=`echo $M_PROCESS| cut -d' ' -f3`
NAME=`echo $M_PROCESS| cut -d' ' -f1`
PORT=`lsof -i -P | grep -i LISTEN | grep "$PROCESS_ID" | awk '{print $(NF-1)}' | sed -e 's/.*://g'`
echo "$NAME","$CPU","$MEMORY","$PORT","$PROCESS_ID" >> result.txt

C_PROCESS_ID=`echo $C_PROCESS| cut -d' ' -f4`
C_MEMORY=`echo $C_PROCESS| cut -d' ' -f2`
C_CPU=`echo $C_PROCESS| cut -d' ' -f3`
C_NAME=`echo $C_PROCESS| cut -d' ' -f1`
C_PORT=`lsof -i -P | grep -i LISTEN | grep "$C_PROCESS_ID" | awk '{print $(NF-1)}' | sed -e 's/.*://g'`
echo "$C_NAME","$C_CPU","$C_MEMORY","$C_PORT","$C_PROCESS_ID" >> result.txt