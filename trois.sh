#!/bin/bash

#str1 = sort
#str2 = name of file
#str3 = Place



i=1
k=$(($#+1))
while ((i < k)) ; do 
	arg=${!i}
	case $arg in 
		#SORT
		--*)
		;;
		
		#FILE
		-f) j=$((i+1))
			str2=${!j}
			if [[ "$str2" != *'.csv' ]] ; then
				echo "File not usable or not filled in. Exit of the program."
				exit 5
			fi
			i=$((i+1))
			;;
		#PLACE
		'-'[A-Z]) if [ -n "$str3" ] ; then 
				echo "Only one place possible. Exit of the program."
				exit 6
			fi
			if [ $arg = '-F' ] || [ $arg = '-G' ] || [ $arg = '-S' ] || [ $arg = '-A' ] || [ $arg = '-O' ] || [ $arg = '-Q' ] ; then
				str3=$arg
				echo "ça marche"
			else 
				echo "non"
			fi
		

			str3=$arg
			;;
				
		#TYPE OF DATA	
#		-*) Minuscule 
		
		
	
	esac
	i=$((i+1))
done
