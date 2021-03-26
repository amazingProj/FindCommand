# Find command

implements find command of Unix on my own.

This find command only supports these formats of given arguments.
It can be given a command, but it is optional.

# give it a name and command
 
Note:

a flag can be 'd' for a directory or 'f' for a file.

a name (=file/dir-name) can be a regular expression.

a command can be any bash command with no longer than 

3 words such that: ls -l -a work fine with that program, however, ls -l 
-a -h will not be worked. 

```
prompt> search.sh <path> <-type> <flag> <-name> <file/dir-name> <-exec> <command>
  
```
For example:
printing all files from the present working directory that their size in bytes is 100 or less, afterward execute a command on these files.

```
search.sh $PWD -type f -size 100 -exec ls -l -a 
```
# find by size

find all the directory or files whose length is smaller than a given size

Note: as below about the arguments.

```
prompt> search.sh <path> <-type> <flag> <-size> <-exec> <command>
```
For example:


 printing all files from the present working directory that their suffix is: .txt,
    execute a command on these files.
    
```
./search $PWD -type f -name "*.txt" -exec ls -l
```
 
# find by a maxdepth and a name

the find command recursively searches according to the given parameters.

We can send it how much depth from the given path get into 
directories.

```
prompt> ./search.sh <path> <-maxdepth><num> <-type> <flag> <-name> <file/dir-name> <-exec> <command>
  
``` 

For example:
printing all directories from the present working directory that their size in bytes is 100 or less.


```
./search $PWD -type d -size 100 cd
```

# a max depth and a size 


```
prompt> ./search.sh <path> <-maxdepth><num> <-type> <flag> <-size> < > <-exec> <command>
```

For example:

 printing all files that have the suffix .py only in two directories depth from a path (for example present working directory) and execute a command on these files.

```
./search $PWD -maxdepth 2 -type f -name "*.txt" -exec ls -l
```
