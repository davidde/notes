# Useful BASH/Zshell commands

### $ `apt-cache search [searchterm]`   
See which packages are available with 'searchterm'.

### $ `cat package.json`  
Show the content of the 'package.json' file.
 
* `cat >package.json`  
Create package.json from command line. This command will await input from user;  
after typing/copying text, press **CTRL+D** to exit.

* `cat *.VOB > moviename.vob; ffmpeg -i moviename.vob -acodec libfaac -ac 2 -ab 128k -vcodec libx264 -vpre fast -crf 20 -threads 0 moviename.mp4`  
Concatenate .vob dvd files, and then convert them to .mp4.
  
### $ `chmod [permissions] [filepath]`   
chmod = **ch**ange **mod**e:   
Change the file mode / permissions for the file specified by 'filepath'.   

#### Permissions: read (r), write (w), execute (x)
* Read: Allows files to be read.
* Write: Allows files to be written.
* Execute: Allow binary files to be executed, and directories to be entered/searched.
For example if a directory has permissions of 0600 you cannot use the cd command to "change directory" into it,
nor can you list it's contents.

The permissions are internally set as bits, so they are efficiently to represent in octal:   
rwx permissions = 111 in binary = 4+2+1 in octal = 7   
rw– permissions = 110 in binary = 4+2+0 in octal = 6   
r–x permissions = 101 in binary = 4+0+1 in octal = 5   
r–– permissions = 100 in binary = 4+0+0 in octal = 4   
–wx permissions = 021 in binary = 0+2+1 in octal = 3   
–w– permissions = 010 in binary = 0+2+0 in octal = 2   
––x permissions = 001 in binary = 0+0+1 in octal = 1   


Permissions can be specified in either symbolic or octal notation.   
Use `ls -l` or `ll` to verify permissions.

#### Symbolic notation
Symbolic notation uses either +/- r/w/x to add/restrict read/write/execute permissions:   
$ `chmod -x $(find -name '*.ntl')`  
Change the file mode (permissions) by restricting execution (-x) for all files ending in '.ntl'.  
=> This is necessary for example to have Python read it as text-type instead of binary-type on Mac.   
`chmod +x` would allow execution; be aware though that `+x` sets the execute bits of the user, group *and* other.  
If you wish to set the execute bit more specifically, use:   
  $ `chmod u+x 'filename'` to set the execute bit for the user.   
  $ `chmod g+x 'filename'` to set the execute bit for the group.   
  $ `chmod o+x 'filename'` to set the execute bit for other.   

#### Octal notation
Octal notation uses a 4 number format to denote which permissions bits are set for the user,
group and other: 0UGO.   
* The leading 0 denotes octal, but can also be used for setting **special modes** (see ahead).
This leading 0 has no special significance and can be left out;   
`chmod 0755 foo.sh` = `chmod 755 foo.sh`   
* The second number (or first when the leading 0 is left out) indicates the permission bits of the user.
* The third number indicates the permission bits of the group.
* The fourth number indicates the permission bits of other.

#### Classification of Users: user, group and other
* **user**: The user is the owner of the files. The user of a file or directory can be changed with the `chown` command.
Read, write and execute privileges are individually set for the user with 0400, 0200 and 0100 respectively.
Combinations can be applied as necessary eg: 0700 is read, write and execute for the user.   

* **group**: A group is the set of people that are able to interact with that file.  
The group set on a file or directory can be changed with the `chgrp` command.  
Read, write and execute privileges are individually set for the group with 0040, 0020 and 0010 respectively.
Combinations can be applied as necessary eg: 0070 is read, write and execute for the group.

* **other**: Represents everyone who isn't an owner or a member of the group associated with that resource.
Other is often referred to as "world", "everyone" etc.
Read, write and execute privileges are individually set for the other with 0004, 0002 and 0001 respectively.
Combinations can be applied as necessary eg: 0007 is read, write and execute for other.

The default permissions are 0755 for directories, and 0644 for files.

#### Special Modes
* **setuid**: Binary executables with the setuid bit can be executed with the privileges of the file's owner.   
Due to it's nature it should be used with care. It has no effect if the user does not have execute permissions.
  - Symbolic notation: u+s (also represented as 's' in the output of ls, or 'S' when it has no effect)   
  `chmod u+s foo.sh`
  - Octal notation: 4000   
  `chmod 4755 foo.sh`

* **setgid**: Binary executables with the setgid bit can be executed with the privileges of the file's group.   
A useful property is to **set the setgid bit on a directory so that all files and directories newly created
within it inherit the group from that directory**. setgid has no effect if the group does not have execute permissions.
  - Symbolic notation: g+s (also represented as 's' in the output of ls, or 'S' when it has no effect)   
  `chmod g+s foo.sh`
  - Octal notation: 2000   
  `chmod 2755 foo.sh`

* **Sticky bit**: The sticky bit is most commonly used on directories where it allows the files or directories within
to only be moved or deleted by that object's owner, the directory owner, or the superuser.
The sticky bit has no effect if other does not have execute permissions.
  - Symbolic notation: +t (also represented as 't' in the output of ls, or 'T' when it has no effect)   
  `chmod +t foo.sh`
  - Octal notation: 1000   
  `chmod 1755 foo.sh`

These special modes can also be combined, e.g. 7000 sets all the special bits: `chmod 7755 foo.sh`.

Check out the [chmod permissions calculator](http://permissions-calculator.org/) to better visualise file permissions.

### $ `chown -R  [username]:[groupname]  [filepath]`   
Change ownership of the file/directory with 'filepath' to the specified 'username' and 'groupname'.   
Simply use `chown [username]` if you don't want to change group ownership.   
Use `chown [username]:`, note the left-out group, if you want to set the groupname
to the default group for that user.   
If you want to change only the group, you can use `chown :[groupname]`(note the left-out user).   
-R, --recursive: Also change ownership of all files/directories inside the specified directory.   
(Files/directories created in the future will not inherit the newly set 'username' or 'groupname',
but resort to the old ones specified by the system.)   
Example:   
$ sudo chown -R david /www   
This changes the ownership of /www (and its content) from the root user to david.   
If the directory is empty, the -R flag is pointless; it will not do anything for files yet to be created ...

* curl -i -X POST -d "isbn=978-1470184841&title=Metamorphosis&author=Franz Kafka&price=5.90" localhost:3000/books/create  
curl = see url; it returns the content at the requested url  
-i: include http headers  
-X: Specify request command to use (e.g. POST, default is GET)  
-d: HTTP POST data

* diff -u old_file new_file  
Check where the differences between 2 versions of a file are.  
(-u = unified diff format => easier to read.)

* dpkg -s "packagename"   
dpkg: Debian Package Manager   
Check the status (-s, --status) of the package named "packagename", i.e. is it installed, what does it do, etc.   
Make sure to use the official packagename or it won't work. If not sure about the name, use:   
$ apt-cache search "packagename"   
This will list either the official name of your package or similar packages.

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

* find   
Recursively finds all files/directories in the current directory and its subdirectories.   
You can specify another path to find items in, like so:   
$ find app   
This will return everything contained in the app directory (which should itself be in the current directory;
otherwise specify an absolute path).Some of find’s power comes from it’s ability to filter which
files or directories it 'selects'.
It does this by using **'tests'**, e.g.:   
-type: f (file) or d (directory)   
$ find app -type f   
Find all files in the app directory, including files in its subdirectories.   
-maxdepth 1: Do not recurse into subdirectories.   
$ find -type f -maxdepth 1   
Find all files in the current directory, excluding files in its subdirectories.   
-name: Takes a glob that will be matched against the base of the filename (filepath without leading directories).   
$ find -name '*.ntl'   
Find all files with the extension '.ntl' in the current working directory and its subdirectories.   
-path: Same as -name, but applies to the whole filepath (including leading directories).   
-regex: takes a regex pattern.   
-amin 5: returns files last **a**ccessed less than 5 minutes ago.   
-mmin 5: returns files last **m**odified less than 5 minutes ago.   
-atime 5: returns files last **a**ccessed less than 5 days ago.   
-mtime 5: returns files last **m**odified less than 5 days ago.   
-user 'uname': returns files owned by user 'uname'.   
-group 'gname': returns files owned by group 'gname'.   
On top of that, find can also directly do something with the results it finds; it accomplishes this with **actions**:   
-delete: Deletes the files that were found. Be careful!   
First run without the -delete flag, so you see which files will be deleted.   
-exec 'command': Executes 'command' on the files that were found.   
$ find /www -type d -exec chmod 2750 {} \;   
$ find /www -type f -exec chmod 0640 {} \;   
These examples combine find with the chmod command to set different permissions on the files vs directories
in the /www directory. `{}` is replaced by the file paths generated by find.
The semicolon `;` denotes the end of the command, but needs to be escaped with `\`,
otherwise it would be interpreted by the shell itself instead of find.

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

* ip a  
Find your IP address in the output:   
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 56:00:01:f1:54:e8 brd ff:ff:ff:ff:ff:ff
    inet 95.179.191.141/23 brd 95.179.191.255 scope global dynamic ens3
       valid_lft 80247sec preferred_lft 80247sec
    inet6 fe80::5400:1ff:fef1:54e8/64 scope link 
       valid_lft forever preferred_lft forever
```
'95.179.191.141' is the IP address of this machine.

* java -jar briss-0.9.jar  
(in directory where briss-0.9.jar is located; requires java)  
Start up briss, app to crop/resize/split pdfs.

* ls -hal /path/to/directory/or/file  
Show stats of the directory or file, including permissions (and which files for directories).  
-h (human-readable): Files sizes are displayed in the human-readable format of kilobytes and megabytes.  
-a (all): Display hidden files, including the directory itself, and its parent directory.  
-l (list): Display more information in a well-ordered list.  
=> On most systems, `ll` is an alias for `ls -lh` or `ls -la`, enter `type ll` to find out which.

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

* passwd   
Change the password for the current user.   
To change the password of root:   
  - Login to root with either:   
  $ su -   
  $ sudo -i   
  - Change the password:    
  $ passwd
  - Log back out using `exit`, `CTRL + D` or `su - username`.
  - Test login using new password:   
  $ su -

* rename -S .rar .cbr *.rar  
(**Mac version** of rename by Aristotle Pagaltzis; this is a newer implementation of
Debian's version by Larry Wall, which it is backwards compatible with, meaning the Mac version
understands "rename 's/.rar/.cbr/' *.rar", but Debian's version does not have the -S flag.)  
Batch rename all files in the current working directory from .rar to .cbr  
-s, --subst: Perform a simple textual substitution of "from" to "to".
The "from" and "to" parameters must immediately follow the argument.  
-S, --subst-all: Same as "-s", but replaces every instance of the "from"
text by the "to" text.  
-n, --dry-run, --just-print: no-execute mode; just print out the changes without actually making them.  
-v, --verbose: Print additional information about the operations (not) executed.

* rename -n 's/.rar/.cbr/' *.rar  
(**Debian/Ubuntu Perl-based version** of rename by Larry Wall & Robin Barker,  
named 'prename' on CentOS and Fedora!)  
Batch rename all files in the current working directory from .rar to .cbr  
-n, -nono: no-execute mode; just print out the changes without actually making them.  
-v, -verbose: Print names of files successfully renamed.  

**Note**: Both rename versions are powerful commands that fully support Perl [regular expressions](./regex.md).

* rename -n 's/(?<=\w)(?=[A-Z])/ /g' *.txt  
~ rename -n 's/([A-Z])/ $1/g' *.txt  
Batch rename all .txt files in current directory to have spaces before uppercase letters. The second command,
although much simpler, will also add a space before the first letter of the filename if it is uppercase.

* Remove the text 'useless_prefix_' from filenames/directories:  
Mac: rename -nS useless_prefix_ '' *  
Deb: rename -n 's/useless_prefix_//' *  
The Debian command will work on Mac, but not the other way around.

**Note**: There is still another 'rename' in use on older Red Hat and CentOS distributions!

* ssh remote_username@remote_ipaddress (-i /path/to/privatekey)    
SSH into the server with IP address 'remote_ipaddress' as user 'remote_username'.  
If your username is the same locally and on the server, you can leave it out:  
$ ssh ipaddress  
-i: Only required when using a private key not named '~/.ssh/id_rsa'.  
-p: Port to connect to on the remote host. Only required when it's a non-standard port number for ssh.   
-vvv: verbosity, useful for debugging.   
Enter `exit` or press **CTRL + D** to exit the remote server.   
For more info on SSH, go [here](./SSH.md).

* su - david  
Switch to the user 'david' (su = **s**witch **u**ser). You can also switch to the root user
by invoking the command with no parameter. Unlike `sudo`, `su` asks you for the password of the user you switch to.   
Note `su -` here:  
`su -` invokes a login shell after switching the user, which resets most environment variables, providing a clean base.   
`su` just switches the user, providing a normal shell with an environment nearly the same as with the old user.   
This means it's generally safest to use `su -`.

* sudo 'command'   
`sudo` is meant to run a single command with root privileges. 
Unlike `su` it prompts you for the password of the current user. This user must be in the sudoers file (`/etc/sudoers`),
or a group that is in the sudoers file. By default, Ubuntu "remembers" your password for 15 minutes,
so that you don't have to type your password every time.

* sudo cat /etc/sudoers   
Print out the sudoers file; this file contains the rules that users must follow when using the sudo command.
You should never edit it directly, but use the `visudo` command (< vi + sudo):   
$ visudo
Check the man pages for extra info on the sudoers file / vi(m) / visudo:   
$ man sudoers   
$ man vi   
$ man visudo

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

