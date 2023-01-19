#!/bin/bash


str2='data.csv'
cat $str2 | cut -d ';' -f10,11 | tr ',' ';'| awk -F ';' '{if($2>='"40"' && $2<='"50"' && $3>='"40"' && $3<='"5"')print $0}'

