#!/bin/bash

dir="/tmp/arch/"
name=`date +%d-%m-%y`.tar.gz

for i in `cat archive.lst`
do
	list=$list" "$i
done;

echo $list

#dont forget to remove v
tar -pzcvf $dir/$name $list
