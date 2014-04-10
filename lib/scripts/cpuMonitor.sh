#!/bin/sh

CPULOG_1=$(cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')
SYS_IDLE_1=$(echo $CPULOG_1 | awk '{print $4}')
Total_1=$(echo $CPULOG_1 | awk '{print $1+$2+$3+$4+$5+$6+$7}')

PCPULOG_1=$(cat /proc/$1/stat | awk '{print $15 " " $16 " " $17 " " $18}')
PTotal_1=$(echo $PCPULOG_1 | awk '{print $1+$2+$3+$4}')

sleep 3

CPULOG_2=$(cat /proc/stat | grep 'cpu ' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')
SYS_IDLE_2=$(echo $CPULOG_2 | awk '{print $4}')
Total_2=$(echo $CPULOG_2 | awk '{print $1+$2+$3+$4+$5+$6+$7}')

PCPULOG_2=$(cat /proc/$1/stat | awk '{print $15 " " $16 " " $17 " " $18}')
PTotal_2=$(echo $PCPULOG_2 | awk '{print $1+$2+$3+$4}')

PRO_TOTAL=`expr $PTotal_2 - $PTotal_1`
 
SYS_IDLE=`expr $SYS_IDLE_2 - $SYS_IDLE_1`
 
Total=`expr $Total_2 - $Total_1`
SYS_USAGE=`expr $PRO_TOTAL/$Total*100 |bc -l`
 
SYS_Rate=`expr $SYS_USAGE |bc -l`
 
Disp_SYS_Rate=`expr "scale=3; $SYS_Rate/1" |bc`
echo $Disp_SYS_Rate%