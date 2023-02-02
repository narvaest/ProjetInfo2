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
		--*) 
			if [ $arg = '--help' ] ; then 
				echo -e "Hello World !\nWelcome in our weather project.\nThis is an aid to help you understand how to use our program. You can sort our program via 3 modes. \nFirst of all, it is imperative to enter the file containing the data by following this formulation: -f <file>\nIf we do not find this data, the program will not even take the time to respond to your request. \nNow here are the features we included in the script : \n*******************************************************************************************************\n1 ) GEOGRAPHICAL POSITIONS. You can process your data according to their geographical positions. Only one geographical position is authorized but if no place has been entered, the software will take everything into account. Here is more info :\n\t-F : Metropolitan France\n\t-G : French Guyana\n\t-S : Saint-Pierre et Miquelon\n\t-A : French West Indies\n\t-O : Indian Ocean\n\t-Q : Antarctic\n*******************************************************************************************************\n2) SORT TYPE. You can sort your data using a specific sorting type. Only one type of sort is authorized but if no type of sort has been entered, the software will sort the data with an avl. Here is more info :\n\t--avl : AVL\n\t--abr : ABR\n\t--tab : TAB\n*******************************************************************************************************\n3) TYPE OF DATA. Several types of data are allowed to you. You can use as much data as you want, but one of them is necessary for the program to work. Here is more info :\n\t-p<number> : Pressure\n\t-t<number> : Temperature\n\t-w : Wind\n\t-m : Moisture \n\t-h : Height\nWarning : <number> correspond to different type of sorting. It's between 1 and 3 and must be informed.\n*******************************************************************************************************\nThanks you for using our program ! "
				exit 99
			fi
			if [ -n "$str1" ] ; then 
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
if [ -z "$str1" ] ; then
	str1="--avl"
fi

#if -f non renseigné --> message d'erreur
if [ -z "$str2" ] ; then
	echo "File not detected. The program will be empty. End of the program."
	exit 12
fi

#if pas d'options choisies --> message d'erreur
if [ -z "$str4" ] && [ -z "$str5" ] && [ -z "$str6" ] && [ -z "$str7" ] && [ -z "$str8" ] ; then
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
	case "$str4" in
		-p1) cat $str2 | cut -d ';' -f1"$arg4" | awk -F ';' '{if($2!='"0"' || $3!='"0"' || $4!='"0"')print $0}' > sortpressure.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sortpressure.csv
		;;
		-p2) cat $str2 | cut -d ';' -f1,2"$arg4" | awk -F ';' '{if($3!='"0"' || $4!='"0"' || $5!='"0"')print $0}' > sortpressure.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sortpressure.csv
		;;
		-p3) cat $str2 | cut -d ';' -f1,2"$arg4" | awk -F ';' '{if($3!='"0"' || $4!='"0"' || $5!='"0"')print $0}' > sortpressure.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sortpressure.csv
		;;
	esac
fi

echo "Loading 40%"
if [ -n "$str5" ] ; then
	if [ "$str5" = '-t2' ] || [ "$str5" = '-t3' ] ; then 
		argdatet=",2"
	fi
	case "$str5" in
		-p1) cat $str2 | cut -d ';' -f1"$arg5" | awk -F ';' '{if($2!='"0"' || $3!='"0"' || $4!='"0"')print $0}' > sorttemperature.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sorttemperature.csv
		;;
		-p2) cat $str2 | cut -d ';' -f1,2"$arg5" | awk -F ';' '{if($3!='"0"' || $4!='"0"' || $5!='"0"')print $0}' > sorttemperature.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sorttemperature.csv
		;;
		-p3) cat $str2 | cut -d ';' -f1,2"$arg5" | awk -F ';' '{if($3!='"0"' || $4!='"0"' || $5!='"0"')print $0}' > sorttemperature.csv
		#Envoi au C
	
		#Appel d'un fichier gnuplot?

		#rm sorttemperature.csv
		;;
	esac

fi

echo "Loading 50%"
if [ -n "$str6" ] ; then
	cat $str2 | cut -d ';' -f1"$arg6" | awk -F ';' '{if($2!='"0"' || $3!='"0"')print$0}' > sortwind.csv
	#Envoi au C
	
	
	#rm sortwind.csv
fi

echo "Loading 60%"
if [ -n "$str7" ] ; then
	cat $str2 | cut -d ';' -f1"$arg7" | awk -F ';' '{if($2!='"0"')print $0}' > sortheight.csv
	#Envoi au C
	
	
	#rm sortheight.csv
fi

echo "Loading 70%"
if [ -n "$str8" ] ; then
	cat $str2 | cut -d ';' -f1"$arg8" | awk -F ';' '{if($2!='"0"')print $0}' > sortmoisture.csv
	#Envoi au C
	
	
	#rm sortmoisture.csv
fi

echo "Loading 100%"




#Ce qu'il me reste à faire 
#- awk --> valeur nulle ?
#- comment envoyer au c
#- gnuplot
#- date (jsp si ça marche)?

