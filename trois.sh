#!/bin/bash

#str1 = sort
#str2 = name of file
#str3 = Place
#str4 = Pressure
#str5 = Temperature
#str6 = Wind
#str7 = Height
#str8 = Humidity

i=1
k=$(($#+1))
while ((i < k)) ; do 
	arg=${!i}
	case "$arg" in 
		#SORT
		--*) if [ -n "$str1" ] ; then 
					echo "Only one sort possible. Exit of the program."
					exit 6
			fi
			if [ $arg = '--avl' ] || [ $arg = '--abr' ] || [ $arg = '--tab' ] ; then
				str1=$arg
			else
				echo "Sort do not exist. Exit of the program"
				exit 4
			fi
		;;		
		
		#FILE
		-f) if [ -n "$str2" ] ; then 
					echo "Only one file possible. Exit of the program."
					exit 6
			fi
			j=$((i+1))
			arg2=${!j}
			if [[ "$arg2" != *'.csv' ]] ; then
				echo "File not usable or not filled in. Exit of the program."
				exit 5
			fi
			str2=$arg2
			i=$((i+1))
			;;
		
		#PLACE
		'-'[[:upper:]])
			if [ -n "$str3" ] ; then 
					echo "Only one place possible. Exit of the program."
					exit 6
			fi
			if [ $arg = '-F' ] || [ $arg = '-G' ] || [ $arg = '-S' ] || [ $arg = '-A' ] || [ $arg = '-O' ] || [ $arg = '-Q' ] ; then
				str3=$arg
			else 
				echo "Place do not exist. Exit of the program."
				exit 7
			fi
			str3=$arg
			;;
				
		#TYPE OF DATA	
		'-'[[:lower:]]*)
					if [ $arg = '-p1' ] || [ $arg = '-p2' ] || [ $arg = '-p3' ] ; then 
						if [ -n "$str4" ] ; then 
							echo "Data "$arg" already given. Exit of the program."
							exit 8
						fi
						str4=$arg
					elif [ $arg = '-t1' ] || [ $arg = '-t2' ] || [ $arg = '-t3' ] ; then
						if [ -n "$str5" ] ; then 
							echo "Data "$str5" already given. Exit of the program."
							exit 8
						fi
						str5=$arg
					elif [ $arg = '-w' ] ; then
						if [ -n "$str6" ] ; then 
							echo "Data "$str6" already given. Exit of the program."
							exit 8
						fi
						str6=$arg
					elif [ $arg = '-h' ] ; then 
						if [ -n "$str7" ] ; then 
							echo "Data "$str7" already given. Exit of the program."
							exit 8
						fi
						str7=$arg
					elif [ $arg = '-m' ] ; then 
						if [ -n "$str8" ] ; then 
							echo "Data " $str8 " already given. Exit of the program."
							exit 8
						fi
						str8=$arg
					else 
						echo "Data do not exist. Exit of the program."
						exit 9
					fi
					;;		
					
		#ERRORS
		*) echo $arg "is not detected. Exit of the program."
			exit 10
			;;
					
	esac
	i=$((i+1))
done

echo $str1 $str3 $str4 $str5 $str6 $str7 $str8 > tri.csv

case "$str3" in
	-G) 
	;;
	-F)
	;; 
	-S)
	;;
	-A)
	;;
	-O)
	;;
	-Q)
	;; 
	*) 
	;;
esac

