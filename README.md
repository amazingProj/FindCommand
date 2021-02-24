# Find command

implements find command of unix by my own.

Formats:

1:

```
prompt> ./search.sh <path> <-type> <flag> <-name> <file/dir-name> <-exec> <command>
  
```
2:  

```
prompt> ./search.sh <path> <-type> <flag> <-size> <-exec> <command>
```

3:
```
prompt> ./search.sh <path> <-maxdepth><num> <-type> <flag> <-name> <file/dir-name> <-exec> <command>
  
```  
4:  
```
prompt> ./search.sh <path> <-maxdepth><num> <-type> <flag> <-size> < > <-exec> <command>
```

#       Examples:

1.  printing all files from present working direcory that thier size in bytes is 100 or less,
    execute a command on these files.

```
./search.sh $PWD -type f -size 100 -exec ls -l -a 
```

2.  printing all files from present working direcory that thier suffix is: .txt,
    execute a command on these files.
    
```
./search $PWD -type f -name ".txt" -exec ls -l
```

3. printing all directory from present working direcory that thier size in bytes is 100 or less.


```
./search $PWD -type d -size 100 
```

4. printing all file that have the suffix .py only in two directories depth from path (for example: present working direcory) and execute a command on these files.

```
./search $PWD -maxdepth 2 -type f -name ".txt" -exec ls -l
```
