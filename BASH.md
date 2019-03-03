# Useful BASH/Zshell commands

* cat >package.json  
Create package.json from command line. This command will await input from user;  
after typing/copying text, press CTRL+D to exit.

* cat package.json  
 Show the content of the 'package.json' file.

* cat *.VOB > moviename.vob; ffmpeg -i moviename.vob -acodec libfaac -ac 2 -ab 128k -vcodec libx264 -vpre fast -crf 20 -threads 0 moviename.mp4  
Concatenate .vob dvd files, and then convert them to .mp4

* chmod -x $(find . -name '*.ntl')  
Change the file mode (chmod) by restricting execution (-x) for all files ending in ‘.ntl’.  
The file will no longer be an ‘Unix executable file’.  
=> This is necessary to have Python read it as text-type instead of binary-type

* curl -i -X POST -d "isbn=978-1470184841&title=Metamorphosis&author=Franz Kafka&price=5.90" localhost:3000/books/create  
curl = see url; it returns the content at the requested url  
-i: include http headers  
-X: Specify request command to use (e.g. POST, default is GET)  
-d: HTTP POST data

* diff -u old_file new_file  
Check where the differences between 2 versions of a file are.  
(-u = unified diff format => easier to read.)

* ~/.dropbox-dist/dropboxd  
Execute dropbox-daemon on Linux

* ffmpeg -i input.mov -vcodec libx264 -crf 24 output.mp4  
Convert input.mov to output.mp4 and compresses the video with a constant rate
factor of 24!

* ffmpeg -i input.mov -acodec copy -vcodec copy output.mp4  
Only convert the video.

* ffmpeg -i input.mp4 -b 1000000 output.mp4  
Change the bitrate (quality) to 1000000 bytes/sec.
(Calculate the bitrate you need by dividing 1 GB by the video length in seconds.
So, for a video of length 16:40 (1000 seconds), use a bitrate of 1000000 bytes/sec.)  
Bitrate= video in bytes/ length in seconds

* find . -name '*.ntl'  
Find all files with the extension ‘.ntl’ in the current working directory (= .).
Files in subdirectories are also found.

* for file in *.rar  
    $ do  
    $ mv "$file" "${file%.rar}.cbr"  
    $ done  

    => Batch rename all files in the current working directory from .rar to .cbr!  
    => Other option for same result: rename or mmv

* grep -r "StringToFind" .  
Look for "StringToFind" in all files in the current directory (.)  
-r: look recursively (i.e. also look in subdirectories)

* Install more recent versions of software than what Debian 9 (stretch) provides by default, e.g. for newer git:  
$ echo "deb http://ftp.debian.org/debian stretch-backports main" | sudo tee /etc/apt/sources.list.d/stretch-backports.list  
$ sudo apt-get update  
$ sudo apt-get install -t stretch-backports git  
=> Backports will install the latest stable version of git instead of the one included in stretch.

* java -jar briss-0.9.jar  
(in directory where briss-0.9.jar is located; requires java)  
Start up briss, app to crop/resize/split pdfs.

* mmv "long_name*.txt" "short_#1.txt"  
Where the "#1" is replaced by whatever is matched by the first wildcard.
Similarly #2 is replaced by the second, etc. Quotes are necessary!  
**Options**:  
-n: no-execute mode; just print out the changes without actually making them.

So you do something like:

* mmv "index*_type*.txt" "t#2_i#1.txt"  
To rename index1_type9.txt to t9_i1.txt

* qpdf -decrypt InputFile OutputFile  
Remove protection/encryption from pdf files

* rename -S .rar .cbr *.rar  
(**Mac version** of rename by Aristotle Pagaltzis)  
Batch rename all files in the current working directory from .rar to .cbr  
-s, --subst: Perform a simple textual substitution of "from" to "to".
The "from" and "to" parameters must immediately follow the argument.  
-S, --subst-all: Same as "-s", but replaces every instance of the "from"
text by the "to" text.  
-n, --dry-run, --just-print: no-execute mode; just print out the changes without actually making them.

* rename -n 's/.rar/.cbr/' *.rar  
(**Debian/Ubuntu Perl-based version** of rename by Larry Wall & Robin Barker,  
named 'prename' on CentOS and Fedora!)  
Batch rename all files in the current working directory from .rar to .cbr  
-n, -nono: no-execute mode; just print out the changes without actually making them.  
Note that this powerful command fully supports Perl regular expressions (regexes);
see ahead for a quick 'Regex intro'.

* rename -n 's/(?<=\w)(?=[A-Z])/ /g' *.txt  
~ rename -n 's/([A-Z])/ $1/g' *.txt  
Batch rename all .txt files in current directory to have spaces before uppercase letters. The second command,
although much simpler, will also add a space before the first letter of the filename if it is uppercase.

**Note**: There is still another 'rename' in use on older Red Hat and CentOS distributions!

**Regex intro**:  
a) Search and replace is performed using 's/regex/replacement/modifiers';  
's' stands for 'substitute', 'regex' is the regex pattern that you want to replace,
'replacement' is what it should be replaced by, and the modifiers are options of the
regex itself, e.g.:  
'g': global; affects all occurrences of the expression  
'i': perform case-insensitive substitution  
$ rename -n 's/DSC/photo/gi' *.jpg   
=> This would apply to all .jpg files that contain 'DSC', 'dsc' or 'dSC',
and change that part of the filename to 'photo'.  
b) Translation is performed using 'y/regex/replacement/modifiers', which is most often 
used to change the filename case:  
$ rename 'y/a-z/A-Z/' *.jpg  
=> This would change the names of all .jpg files from lowercase to uppercase.  
c) Legend:  

|   regex      |        Meaning                 |             Examples                         |
|--------------|--------------------------------|----------------------------------------------|
|  .           | any character except newline   | ".a" matches two consecutive characters where the last one is "a" |
|  ^           | - anchor for start of string   | "^a" matches "a" at the start of the string  |
|              | - negation symbol              | "[^0-9]" matches any non digit               |
|  $           | - anchor for end of string     | "b$" matches "b" at the end of a line        |
|              |                                | "^$" matches the empty string                |
|              | - backreference at sub-expression | A search for "(a)(b)" in the string "abc", followed by a replace "\2\1" results in "bac" |
|  < >         | anchors that specify a left or right word boundary |                          |
|  *           | match-zero-or-more quantifier  | "^.*$" matches an entire line                |
|  +           | match-one-or-more quantifier   |                                              |
|  ?           | match-zero-or-one quantifier   |                                              |
|  \|          | separates a series of alternatives | "(a\|b\|c)a" matches "aa" or "ba" or "ca"  |
|                                                                                              |
|  \           | escape character               |                                              |
|  \\. \\* \\\	| escaped special characters     | "\\." matches the literal dot "."            |
|              |                                | "\\\\" matches the actual backslash "\\"     |
|  \t \n \r    |	tab, linefeed, carriage return |
|  \w \d \s    | word, digit, whitespace        |
|  \W \D \S    | not word, digit, whitespace    |	
|                                                                                              |
|  { }         | range quantifiers              | "a{2,3}" matches "aa" or "aaa"               |
|  ( )         | used for grouping characters or other regexes |                               |
|  [ ]         | character class to match a single character |                                 |
|  [abc]	      | any of a, b, or c              |
|  [^abc]     	| not a, b, or c                 |
|  [a-g]	      | character between a & g        |
|  [A-Z]	      | any uppercase letter           |
|                                                                                              |
|  (?=…)       |	Positive lookahead	            | (?=\d{10})\d{5} matches	01234 in 0123456789  |
|  (?<=…)      | Positive lookbehind	           | (?<=\d)cat matches	cat in 1cat               |
|  (?!…)       |	Negative lookahead             |	(?!theatre)the\w+	theme                      |
|  (?<!…)      | Negative lookbehind            |	\w{3}(?<!mon)ster	Munster                    |


* sudo apt -f install  
-f: 'fix broken'  
Fix broken dependencies.

* sudo apt update  
Update package lists (installed applications list).

* sudo apt dist-upgrade  
Upgrade your machine.

* sudo apt update && time sudo apt dist-upgrade  
Update package lists and upgrade your machine while timing it.

* sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 'PUBKEY'  
Fix the GPG error 'NO_PUBKEY', for example when adding a ppa to your system.  
When you run `sudo apt update` with this ppa error, you will get;  
`W: GPG error: http://ppa.launchpad.net trusty Release:  
The following signatures couldn't be verified because the public key  
is not available: NO_PUBKEY 93C4A3FD7BB9C367`,  
where `93C4A3FD7BB9C367` is the 'PUBKEY' you need to use in the command.

* sudo fs_usage | grep [path_to_file]  
Find out which application is touching the file.

* sudo lsof -i :8000  
Detect what process is listening to (and occupying) port 8000.

* sudo kill -9 <PID>  
Kill process with PID.

* tail -f *.log  
Follows (-f) all log files, so you can troubleshoot.
(tail = last 10 lines)

More specific logs:  
* tail -f /var/log/kern.log   
// kernel-only, i.e. dmesg output

* tail -f /var/log/syslog     
// kernel + programs

* touch file.txt  
Create an empty file called 'file.txt'.

