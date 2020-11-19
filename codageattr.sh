#!/bin/bash
rm data.csv
head -1000 datafinal.csv > data.csv

#transformation des dates vers seconde
fonction ()
{
a=$1
b=$(echo $a | cut -f1 -d'/')
c=$(echo $a | cut -f2 -d'/')
d=$(echo $a | cut -f3 -d'/')
date -d $(echo $d"/"$c"/"$b) "+%s"
}
d=""
list=""
#lecture de chaque ligne
while read line 
do 
	for i in {1..24}
	do 
	a=$(echo $line | cut -f$i -d';' )
		if [ $i -eq 1 ]
			then
			 d=$(echo $line | cut -f1 -d';' )
		# la date 
		elif [ $i -eq 2 ]
			then 
			a=$(fonction $a)
			d=$d";"$a
		# codage des medicaments
		elif [ $i -eq 3 ]
			then 
			a=$(echo $a | tr -d " ")
			i=0 
			change=0
			for item in $list
			do	  
			    if [ $a = $item ]
				then
				a=$i
				change=1
				break
			    else 
				i=$((i+1))
			    fi
			done

			if [ "$change" == "0" ]; then 
				list+=$a" "
				a=$i  
			fi
			d=$d";"$a
		# codage des medicaments
		elif [ $i -eq 4 ]
			then 
			a=$(echo $a | tr -d " ")
			i=0 
			change=0
			
			for item in $list
			do	  
				
			    if [ "$a" = $item ]
				then
				a=$i
				change=1
				break
			    else 
				i=$((i+1))
			    fi
			done

			if [ "$change" == "0" ]
				then 
				list+=$a" "
				a=$i  
			fi
			d=$d";"$a
		elif [ $i -eq 5 ]
			then 
			a=""
		elif [ $i -eq 8 ]
			then 
				if [ "$a" == "Jour " ]
				then
					a="001"
				elif [ "$a" == "Semaine " ]
				then
					a="010"
				elif [ "$a" == "Mois " ]
				then
					a="100"
				fi

			d=$d";"$a
		elif [ $i -eq 11 ]
			then 
				if [ "$a" == "OUI" ]
				then
					a="1"
				else 
					a="0"
				fi
			d=$d";"$a
		# on donne 1 à OUI et 0 sinon 
		elif [ $i -eq 10 ]
			then 
				if [ "$a" == "OUI" ]
				then
					a="1"
				else 
					a="0"
				fi
			d=$d";"$a
		elif [ $i -eq 16 ]
			then	
			a=""
		elif [ $i -eq 19 ]
			then	
			a=""
		#F on le donne 1 et 0 à M 
		elif [ $i -eq 21 ]
			then 
				if [ "$a" == "F" ]
				then
					a="1"
				else 
					a="0"
				fi
			d=$d";"$a
		#repartition vers labelfile avec leurid 
		elif [ $i -eq 24 ]
			then
			b=$(echo $line | cut -f1 -d';' )
			a=$(echo $line | cut -f$i -d';' )
			echo $b";"$a >> label.csv
		else 
			d=$d";"$a

		fi
	

done
echo $d >> visit.csv
done < data.csv

sort -n visit.csv > visitsorted.csv
sort -n label.csv | tr -d "\r"  > labelsorted.csv

		
