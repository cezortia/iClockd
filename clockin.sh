#!/bin/bash 

# A Unix Clockin Utility 

# Author : Mahesh Bharath Keerthivasan

# Date : February 6 2011 

# Place :  tucson, AZ, USA 

# --------------------------------------------


CURRENT=(`date`)

MNTH=${CURRENT[1]}
DTE=${CURRENT[2]}
YR=${CURRENT[5]}

TIME=${CURRENT[3]}
IFS=":"
TM=($TIME)

# echo ${TM[1]}

HR=${TM[0]}
MIN=${TM[1]}
SEC=${TM[2]}

#echo $HR
#echo $MIN
#echo $SEC


SUFFIX=$DTE$MNTH$YR.txt
#echo $SUFFIX


#touch $HOME/TimeSheet/$SUFFIX

file=$HOME/Documents/TimeSheet/$SUFFIX

echo "Check In Time = $HR : $MIN" >> $file






















