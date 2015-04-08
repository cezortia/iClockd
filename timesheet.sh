#!/bin/bash 

# A Unix TimeSheet Utility 

# Author : Mahesh Bharath Keerthivasan

# Date : February 8  2011 

# Place :  Tucson, AZ, USA 

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

USR=`whoami`
# echo $USR 
directory=$HOME/Documents/Project_bash/TimeSheet/$USR/$MNTH

if [ ! -d $directory ]
then
mkdir -p $directory
fi

file=$directory/$SUFFIX
touch $file

if [ -n "$(echo $1 | grep '^-[ioeh]')" ]
then
OPTION=$1
echo $OPTION
else
printf "usage: timesheet [-i] [-o] [-e] \n" 
printf "timesheet [-h] for more information \n " 
exit 1
fi

case $OPTION in 
	-i ) 

	{
		while read line ; do
#			echo $line
			line_val=$line
		done

	} < $file

#		echo "Last Line of file is $line_val"

		if [ -n "$(echo $line_val | grep '^IN')" ]
		then
			printf "ERROR_001 ! Consecutive clock-ins.\n"
			printf "Please Clock-out before you clock-in again. Your previous clock-in time will be ignored.\n" 
			echo "ERROR_001" >> $file
			exit 1;
		else 	if [ -n "$(echo $line_val | grep '^ERROR_001')" ]
			then
				printf "Please Clock-out before you clock-in again.\n" 
				exit 1;
			else
				echo "IN Time = $HR : $MIN" >> $file 
			fi
		fi;; 

	-h )

		printf "\n NAME \n \t timesheet -  Employee Clockin Utility \n\n \t Author: Mahesh Bharath Keerthivasan \n \t February 2011 \n"
	    	 printf"\n DESCRIPTION \n \t This utility is used to maintain hours of work everyday. It allows the employee to check in and check out using their linux terminal. The hours of work are computed everyday, for every clock-in / clock-out. The utility has the option of preparing a consolidated hours of work table for a specific period as a .csv file compatible with OpenOffice Spreadsheet. \n \t To clock-in yourself use the command timesheet -i \n \t To clock-out after work use the command timesheet -o \n \t Administrators can use the command timesheet -e to consolidate the total hours worked by an employee and save it as a .csv file for records \n"
	    	 printf"\n SYNOPSIS \n \t timesheet [-i clockin] [-o clockout] [-e consolidate worked hours] [-h help] \n\n" ;;
       
	-o ) 

	# Every time clock-out option is selected compute the amount of hours worked until then. This will make computing the total hours easier. ALso it would give the total duration a person worked at a single stretch. Something that could be useful in concentration studies for phychology majors !! 


	{ 
		while read line ; do
#			echo $line 
			line_val=$line
		done

	} < $file
			if [ -n "$(echo $line_val | grep '^IN')" ]
			then
#				echo "Current Line : $line_val"
				IFS=" "
				line_ary=($line_val)

# 				echo $linenext	

				IN_HR=${line_ary[3]}
				IN_MIN=${line_ary[5]}
#				echo "$IN_HR $IN_MIN"

				ELAPSED_HR=$[$HR-$IN_HR]
				ELAPSED_MIN=$[$MIN-$IN_MIN]

				echo "OUT Time = $HR : $MIN" >> $file
				echo "ELAPSED Time = $ELAPSED_HR : $ELAPSED_MIN" >> $file
				
			fi

			if [ -n "$(echo $line_val | grep '^ERROR_001')" ]
			then
				echo "OUT Time = $HR : $MIN" >> $file
			fi

			if [ -n "$(echo $line_val | grep '^ELAPSED')" ]
			then
				printf "ERROR_002 : You should clock-out only after you clock-in. \n"
				printf "Please clock-in \n"
				exit 1;
			fi
							


#				echo "Next Line : $linenext"
				
#				echo "Line array contents ${line_ary[0]}"
#				read linenext
				
#				if [ ! -n "$(echo $linenext | grep '^OUT')" ] 				
#				then
#					echo $linenext
#					if [ -n "$(echo $linenext | grep '^ERROR')" ]
#					then

#						echo "OUT Time = $HR : $MIN" >> $file
						

#					else
# 						echo $linenext	
#						IN_HR=${line_ary[3]}
#						IN_MIN=${line_ary[5]}
#						echo "$IN_HR $IN_MIN"
#						ELAPSED_HR=$[$HR-$IN_HR]
#						ELAPSED_MIN=$[$MIN-$IN_MIN]
#						echo "OUT Time = $HR : $MIN" >> $file
#						echo "ELAPSED Time = $ELAPSED_HR : $ELAPSED_MIN" >> $file
#						echo "Next Line : $linenext"
#						break
#					fi
#				fi

#				if [ -n "$(echo $linenext | grep '^ERROR')" ]
#				then
#					echo "OUT Time = $HR : $MIN" >> $file
#					break
#				fi
				
#			fi
#		done
    
	;;
	
esac

























