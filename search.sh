#!/bin/bash

#initialize the global variables and flags
#flags tell me if there is or there is not a flag among file arguments
pathSaver=$1
path=$1
flag=$3
key=$4
maxDepthf=0

# diffently initialize variables if there is maxdepth
if [ $2 == -maxdepth ]
then
   flag=$5
   maxDepthf=1
   key=$6
fi
execCommandS=0
sizef=0
namef=0
execCommandSS=0
#size or name check

#initialize the flags: sizef and namef
case $key in
  -size) sizef=1;;
  -name) namef=1;;
esac

echo -n $0

execF=0

#prints all arguments

for arg in $*
do

  echo -n $arg
  echo -n  " "

  if [ "$arg" == "-exec" ]
  then
      execF=1
  fi
done
echo
echo please when you enter size do it by regular number such that: 1 or 1000 or 48328 etc.

#intialize maxdepth or not
if [ $maxDepthf == 1 ]
then
 maxdepth=$3
fi

# intialize maxdepth or not execute a bash command variables
if [ $execF == 1 ]
then
execCommand=$7
execCommandS=$8
execCommandSS=$9

 if [ $maxDepthf == 1 ]
then
   shift
   shift
   execCommand=$7
   execCommandS=$8
   execCommandSS=$9

fi
fi

if [[ $namef  ==  1 ]]
then
  if [ $maxDepthf == 1 ]
  then
    name=$7
else
   name=$5
fi

fi
if [[ $sizef == 1 ]]
then
 if [ $maxDepthf == 1 ]
  then
   size=$7
else
   size=$5
fi
fi

#if the name matches the regular expression then print to screen.

function check_name(){
filename=$( basename $1 suffix ) #gets the name of the file from the path
#if one of the file that were given by the regular expression math the name
for file in $name
do
 if [[ $filename == $file ]]
 then
   echo $1
 fi

done
}

# check the byte size of the file if it is less than size

function check_size(){

if [[ -d $1 ||  -f $1 ]]
then
byte=$( du -b $1 | awk '{print $1 }')
if [ $size -gt $byte ]
then
  echo $1
fi
fi

}

#look for a file/dir-name and filter by size
#recursively finds files and print the paths of them
function search_via_size(){
if [ maxDepthf == 1 ]
then
if [ $2 == 0 ]
then
    return
fi
fi

#used for the maxdepth limit
if [ $maxDepthf == 1 ]
then
if [ $2 -eq 0 ]
then
 return
fi
fi

 for i in "$1"/*
 do

 target=$i
        if [[ -d  $target ]]
 then
for file in $i
do
#chose the suitable recursive step
if [ $maxDepthf == 1 ]
then


   search_via_size "$file" $(($2-1))

else
 search_via_size "$file"
fi
done
fi


            if [ $flag == d ]
 then

   check_size $target
            fi

        if [[ -f $target ]]
 then

            if [[ $flag == f ]]
 then
                    check_size $target #if the size is

            fi
        fi

 done

 return
}

#search by name, gets the paths of the matches files

function search_via_name(){

for i in "$path"/*
 do
 path=$i
        if [[ -d  $path ]]
 then
if [ $maxDepthf == 1 ]
then
   ((--$2))
   search_via_name "$path"/* $2
else
 search_via_name "$path"/*
fi

            if [[ $flag == d ]]
 then
   check_name $path
            fi
        fi
        if [[ -f $path ]]
 then

            if [[ $flag == f ]]
 then
                    check_name $path
            fi
        fi
 done

}

#organize all the calls of functions toghether
function start(){
if [ $namef == 1 ]
then
 if [ $maxDepthf == 1 ]
 then
 search_via_name $1 $2
 else
 search_via_name $1
 fi
fi

if [ $sizef == 1 ]
then
 if [ $maxDepthf == 1 ]
then
 search_via_size $1 $2
 else
  search_via_size $1
 fi
fi
}

start $path $3

#exec command ( limit 1-3 words command ) such that the output of the search is the piped to the command
if [ $execF == 1 ]
then
echo
echo
echo "Execute command output "
path=$pathSaver
 y=$(start $path $3)
for file in $y
do
if [[ -d $1 ||  -f $1 ]]
then

if [[ ! $execCommandS == 0 && ! $execCommandSS == 0  ]]
then
 $execCommand $execCommandS $execCommandSS $file

elif [ ! $execCommandS == 0 ]
then
  $execCommand $execCommandS $file


else
   $execCommand $file
fi
fi
done
fi

