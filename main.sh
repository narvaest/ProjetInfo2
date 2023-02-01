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
						arg4=",3,7,8"
					elif [ $arg = '-t1' ] || [ $arg = '-t2' ] || [ $arg = '-t3' ] ; then
						if [ -n "$str5" ] ; then 
							echo "Data "$str5" already given. Exit of the program."
							exit 8
						fi
						str5=$arg
						arg5=",12,13,14"
					elif [ $arg = '-w' ] ; then
						if [ -n "$str6" ] ; then 
							echo "Data "$str6" already given. Exit of the program."
							exit 8
						fi
						str6=$arg
						arg6=",4,5"
					elif [ $arg = '-h' ] ; then 
						if [ -n "$str7" ] ; then 
							echo "Data "$str7" already given. Exit of the program."
							exit 8
						fi
						str7=$arg
						arg7=",15"
					elif [ $arg = '-m' ] ; then 
						if [ -n "$str8" ] ; then 
							echo "Data " $str8 " already given. Exit of the program."
							exit 8
						fi
						str8=$arg
						arg8=",6"
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


#if type de tri non renseigné --> avl
if [ ! "$str1" ] ; then
	str1="--avl"
fi

#if -f non renseigné --> message d'erreur
if [ ! "$str2" ] ; then
	echo "File not detected. The program will be empty. End of the program."
	exit 12
fi

#if pas d'options choisies --> message d'erreur
if [ ! "$str4" ] && [ ! "$str5" ] && [ ! "$str6" ] && [ ! "$str7" ] && [ ! "$str8" ] ; then
	echo "Data not detected. The program will be empty. End of the program."
	exit 13
fi

#Inversion des variables
echo "Loading 10%"
echo "Loading 20%"


case "$str3" in
	-G) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"1"' && $10<='"6"' && $11>='"-57"' && $11<='"-51"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;;
	-F) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"40"' && $10<='"51"' && $11>='"-4"' && $11<='"10"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;; 
	-S) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"46"' && $10<='"48"' && $11>='"-57"' && $11<='"-55"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;;
	-A) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"12"' && $10<='"18"' && $11>='"-65"' && $11<='"-58"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;;
	-O) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"-50"' && $10<='"20"' && $11>='"30"' && $11<='"140"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;;
	-Q) cat $str2 | tr ',' ';' | awk -F ';' '{if($10<='"-50"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
	;; 
#Remove first line (not opti)
	*) cat $str2 | tr ',' ';' | awk -F ';' '{if($10>='"-70"' && $10<='"70"')print $0}' > sortedplaces.csv
		str2="sortedplaces.csv"
esac

echo "Loading 30%"


if [ -n "$str4" ] ; then
	echo "$str4"
	if [ "$str4" = '-p2' ] || [ "$str4" = '-p3' ] ; then 
		argdatep=",2"
	fi
	cat $str2 | cut -d ';' -f1"$arg4""$argdatep" | awk -F ';' '{if($2!='"0"' || $3!='"0"' || $4!='"0"')print $0}' > sortpressure.csv
fi

echo "Loading 40%"
if [ -n "$str5" ] ; then
	echo "$str5"
	if [ "$str5" = '-t2' ] || [ "$str5" = '-t3' ] ; then 
		argdatet=",2"
	fi
	cat $str2 | cut -d ';' -f1"$arg5""$argdatet" | awk -F ';' '{if($2!='"0"' || $3!='"0"' || $4!='"0"')print $0}' > sorttemperature.csv
fi

echo "Loading 50%"
if [ -n "str6" ] ; then
	echo "$str6"
	cat $str2 | cut -d ';' -f1"$arg6" | awk -F ';' '{if($2!='"0"' || $3!='"0"')print$0}' > sortwind.csv
fi

echo "Loading 60%"
if [ -n "str7" ] ; then
	echo "$str7"
	cat $str2 | cut -d ';' -f1"$arg7" | awk -F ';' '{if($2!='"0"')print $0}' > sortheight.csv
fi

echo "Loading 70%"
if [ -n "str8" ] ; then
	echo "$str8"
	cat $str2 | cut -d ';' -f1"$arg8" | awk -F ';' '{if($2!='"0"')print $0}' > sortmoisture.csv
fi

echo "Loading 100%"


#Problèmes à régler 
#- awk --> valeur nulle ?
#- problème ligne 125
#- comment envoyer au c
#- --help
#- supprimer le fichier après utilisations
#- date ?

