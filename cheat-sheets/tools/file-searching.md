## Usage of `find` and similar tools in Linux
### Basic file searching
```
find / -name file.txt -type f -print             # full command
find / -name file.txt -type f                    # -print isn't necessary
find / -name file.txt                            # don't have to specify "type==file"
find . -name file.txt                            # search under the current dir
find . -name "file.*"                            # wildcard
find . -name "*.txt"                            # wildcard
find /users/al -name Cookbook -type d           # search '/users/al'
```
### Case insensitive search
```
find . -iname file                               # find file, File, FiLe, fILE, etc.
find . -iname file -type d                       # same thing, but only dirs
find . -iname file -type f                       # same thing, but only files
```
### Filter by extension or naming pattern
```
find . -type f \( -name "*.c" -o -name "*.sh" \)                       # *.c and *.sh files
find . -type f \( -name "*cache" -o -name "*xml" -o -name "*html" \)   # three patterns
```
### Search by text using `find | grep`
```
find . -type f -name "*.java" -exec grep -l StringBuffer {} \;    # find StringBuffer in all *.java files
find . -type f -name "*.java" -exec grep -il string {} \;         # ignore case with -i option
find . -type f -name "*.gz" -exec zgrep 'GET /file' {} \;          # search for a string in gzip'd files
```
### Search and run commands on them using `-exec`
```
find /usr/local -name "*.html" -type f -exec chmod 644 {} \;      # change html files to mode 644
find htdocs cgi-bin -name "*.cgi" -type f -exec chmod 755 {} \;   # change cgi files to mode 755
find . -name "*.pl" -exec ls -ld {} \;                            # run ls command on files found
```
### Search and copy
```
find . -type f -name "*.mp3" -exec cp {} /home/thm/Music \;       # cp *.mp3 files to /home/thm/Music
```
