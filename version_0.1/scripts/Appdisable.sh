#!/bin/bash
username=(id -u -n)
if [[ $username == admin ]];then
    file=/etc/hosts
    foo=$1
    add="127.0.1.1 $foo "
    echo "$add" >> $file 
else 
    echo "Access denied."
    exit
fi 