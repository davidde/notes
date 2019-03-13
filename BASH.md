# Useful BASH/Zshell commands

* apt-cache search "searchterm"   
See which packages are available with "searchterm".

* cat >package.json  
Create package.json from command line. This command will await input from user;  
after typing/copying text, press CTRL+D to exit.

* cat package.json  
 Show the content of the 'package.json' file.

* cat *.VOB > moviename.vob; ffmpeg -i moviename.vob -acodec libfaac -ac 2 -ab 128k -vcodec libx264 -vpre fast -crf 20 -threads 0 moviename.mp4  
Concatenate .vob dvd files, and then convert them to .mp4

* chmod  "permissions"  "filepath"   
chmod = **ch**ange **mod**e: Change the file mode / permissions for the file specified by 'filepath'.   
'permissions' can be specified in either symbolic or octal notation.   
**Symbolic notation** uses either +/- r/w/x to add/restrict read/write/execute permissions:   
$ chmod -x $(find -name '*.ntl')  
Change the file mode (permissions) by restricting execution (-x) for all files ending in '.ntl'.  
The file will no longer be an ‘Unix executable file’.  
=> This is necessary to have Python read it as text-type instead of binary-type on Mac.   
`chmod +x` would allow execution.   
[chmod permissions calculator](http://permissions-calculator.org/)

* chown -R  "username":"groupname"  "filepath"   
Change ownership of the file/directory with 'filepath' to the specified 'username' and 'groupname'.   
Simply use `chown "username"` if you don't want to change group ownership.   
Use `chown "username":`, note the left-out group, if you want to set the groupname
to the default group for that user.   
If you want to change only the group, you can use `chown :"groupname"`(note the left-out user).   
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

**Note**: Both rename versions are powerful commands that fully support Perl regular expressions (regexes);
see ahead for a quick 'Regex intro'.

* rename -n 's/(?<=\w)(?=[A-Z])/ /g' *.txt  
~ rename -n 's/([A-Z])/ $1/g' *.txt  
Batch rename all .txt files in current directory to have spaces before uppercase letters. The second command,
although much simpler, will also add a space before the first letter of the filename if it is uppercase.

* Remove the text 'useless_prefix_' from filenames/directories:  
Mac: rename -nS useless_prefix_ '' *  
Deb: rename -n 's/useless_prefix_//' *  
The Debian command will work on Mac, but not the other way around.

**Note**: There is still another 'rename' in use on older Red Hat and CentOS distributions!

## Regex intro
### Substitution: using 's/regex/replacement/modifiers'  
's': substitute  
'regex': the regex pattern that you want to replace  
'replacement': what should replace the regex  
'modifiers': options of the regex itself, e.g.:  
  - 'g': global; affects all occurrences of the expression  
  - 'i': perform case-insensitive substitution  
$ rename -n 's/DSC/photo/gi' *.jpg   
=> This would apply to all .jpg files that contain 'DSC', 'dsc' or 'dSC',
and change that part of the filename to 'photo'.  

### Translation: using 'y/regex/replacement/modifiers'
-> most often used to change the filename case:  
$ rename 'y/a-z/A-Z/' *.jpg  
=> This would change the names of all .jpg files from lowercase to uppercase.  

### Legend

| regex symbol |        Meaning                 |             Examples                         |
|--------------|--------------------------------|----------------------------------------------|
|  .           | any character except newline   | ".a" matches two consecutive characters where the last one is "a" |
|  ^           | - anchor for start of string   | "^a" matches "a" at the start of the string  |
|              | - negation symbol              | "[^0-9]" matches any non digit               |
|  $           | - anchor for end of string     | "b$" matches "b" at the end of a line        |
|              |                                | "^$" matches the empty string                |
|              | - backreference at sub-expression | A search for "(a)(b)" in the string "abc", followed by a replace "$2$1" results in "bac" |
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

------------------------------------------------------------------------------------------------------

* ssh remote_username@server_ipaddress (-i /path/to/privatekey)    
SSH into the server with IP address 'server_ipaddress' as user 'remote_username'.  
If your username is the same locally and on the server, you can leave it out:  
$ ssh ipaddress  
-i: Only required when using a private key not named '~/.ssh/id_rsa'.  
-p: Port to connect to on the remote host. Only required when it's a non-standard port number for ssh.   
-vvv: verbosity, useful for debugging.   
Enter `exit` or press **CTRL + D** to exit the remote server.

## SSH intro
SSH (Secure SHell) is a networking protocol, commonly used to 'log in' to a VPS or cloud server.  

### Core packages
- openssh-client:  
installed on your computer to initiate a connection with the VPS server using the 'ssh' command;   
e.g. `$ ssh username@vpsserver`  
- openssh-server:  
installed on the VPS server to securely access it from your computer.  

=> When not present:  
$ sudo apt install openssh-client/openssh-server  

When installing openssh-server, the server's public and private keys are generated automatically.
For the client, you'll have to do that on your own (i.e. with the `ssh-keygen` command, see ahead).
When you, the client, connects with a server, public keys are exchanged. You'll receive the servers one,
and the server yours. The first time you receive the server public key, you'll be asked to accept it.
The public keys are stored in **~/.ssh/known_hosts** on the client, and in **~/.ssh/authorized_keys**
on the server.
  
### SSH key pairs
SSH key pairs are two cryptographically secure keys used to authenticate a client to an SSH server.
Each key pair consists of a public key and a private key. The private key is retained by the client
and should be kept absolutely secret (it can be encrypted on disk with a passphrase). The associated
public key can be shared freely without any negative consequences, and is used to encrypt messages
that only the private key can decrypt. This property is employed as a way of authenticating using the key pair.

**The public key is uploaded to a remote server that you want to be able to log into with SSH.**
The key is added to a special file within the user account you will be logging into called ~/.ssh/authorized_keys.
When a client attempts to authenticate using SSH keys, the server can test the client
on whether they are in possession of the private key. If the client can prove that it owns the private key,
a shell session is spawned or the requested command is executed.

### How-to
The first step to configure SSH key authentication to your server is to generate an SSH key pair on your local computer:  
$ ssh-keygen (-C `your_email@example.com`)  
(-C: comment; this can be any random string. This flag is not required, but exists so people can recognize
what/who each key belongs to; in professional environments there are often multiple network techs, 
and typical authorized_keys files can hold dozens of keys. The comment flag can be used however you like,
but is often used to specify an email address to identify who generated the key if there is potential for ambiguity.
Sentences with spaces are also allowed!)  
Your shell will prompt you to select a location for both keys. By default, the keys will be stored in the ~/.ssh directory. 
The private key will be called id_rsa and the associated public key will be called id_rsa.pub.
It is usually best to stick with the default location, so your SSH client will automatically find
your SSH keys when attempting to authenticate. However, if you have previously generated ~/.ssh/id_rsa,
you will be asked permission to overwrite; obviously do not overwrite if you still need to be able to authenticate
using the old key! In this case you need to specify a different name (but note that is is probably more convenient
to simply reuse your existing key).

*Optionally* provide a **passphrase**, which is used to encrypt the private key file on disk.
This is an additional security that makes the private key by itself useless to an attacker.  
Possible security concerns:
- Private keys could be compromised for example if you are not careful with old harddisks or backups,
or your computer itself was compromised.
- The more places a single key is authorized, the more valuable that key becomes.
If that key gets compromised, more targets are put at risk.
- The more places the private key is stored (e.g. desktop, laptop, work computer, backup storage, etc.),
the more places there are for an attacker to grab a copy.

A private key corresponds to a single "identity" for a given user, whatever that means to you.
If, to you, an "identity" is a single person, or a single person on a single machine,
or perhaps a single instance of an application running on a single machine. The level of granularity is up to you.
**There are NO universally-applicable guidelines on how to run your security**; the more additional security you add,
the more convenience you give up.   
E.g. when using a passphrase you have to enter it every time you use this key,
unless you are running `ssh-agent` software that stores the decrypted key.  
However, **keeping your private key encrypted with a passphrase adds a significant amount of security**.

You can change the passphrase for an existing private key without regenerating
the keypair by typing the following command:  
$ ssh-keygen -p  
(You will be prompted to specify the file in which the private key resides.)

### Do SSH keys have to be named 'id_rsa'?
**NO**, you can give them any name you like, or even place them in a different directory.  
(Another name is required when you don't want a single ssh key pair for sshing into multiple servers.)  
However, if they are not named `~/.ssh/id_rsa`, then you need to explicitly reference the key
in the ssh command like so:  
$ ssh user@server -i /path/to/mykey  

It is not uncommon to use multiple key pairs. Instead of running `$ ssh user@server -i /path/to/mykey`,
you can use a **configuration file, ~/.ssh/config**:  
```
Host yourhost
   IdentityFile ~/.ssh/id_dsa
   IdentityFile ~/.ssh/custom_key
```
Common settings are the IdentityFile (= the private keys) and Host. If you omit 'Host yourhost',
the settings will apply to all SSH connections. This configuration will check "id_dsa" and "custom_key" only
as private keys when connecting with `$ ssh youruser@yourhost`.

Example to tell git which private key to use:
```
host github.com
 HostName github.com
 IdentityFile ~/.ssh/github_rsa
 User git
```
Now you can do `$ git clone git@github.com:username/repo.git`.

Another **~/.ssh/config** example for Vultr:  
```
Host vultr
 HostName 198.13.59.103
 Port 22
 User root
 IdentityFile ~/.ssh/vultr_rsa
```
Now you can simply type:   
$ ssh vultr   
Which is equivalent to:   
$ ssh root@198.13.59.103 -i ~/.ssh/vultr_rsa -p 22   
(It would find everything it needs in your  ~/.ssh/config, under the `Host vultr` entry.)
 
**NOTE**: If the config file is new, don't forget to do `$ chmod 600 ~/.ssh/config`.  
Also verify that the permissions on IdentityFile are 400! SSH will reject, in a not clearly explicit manner,
SSH keys that are too readable. It will just look like a credential rejection. The solution, in this case, is:  
$ chmod 400 ~/.ssh/github_rsa

Generally speaking though, using a **single ssh key pair WITH a passphrase** holds a fair middle ground
between security and convenience, especially with the help of `ssh-agent`. But on the other hand, reusing
a single key on too many services *will* make it inconvenient if you ever decide/require to renew it.

### Setting up `ssh-agent`
(This is only necessary when you have set a passphrase for your private key,
and you don't want to specify it on every authentication)
1. Start the ssh-agent in the background:  
$ eval $(ssh-agent)
2. Add your SSH private key to the ssh-agent:
   - If it has the standard 'id_rsa' name, simply run:  
   $ ssh-add  
   - If you created your key with a different name/path, add the path to the command:  
   $ ssh-add ~/.ssh/user1_host1  
   - Enter the passphrase for the specific private key
   
### Adding your public key to a remote server
#### a) Github/Gitlab/etc.
- Open the id_rsa.pub file (or use `$ cat ~/.ssh/id_rsa.pub`) and copy the entire content of that file.
- Login to your account and go to the 'SSH key Settings'.
- Paste the exact content of the public key into the Key input.
- Give it a descriptive name, which will still be meaningful to you 2 years from now.
- Click 'Add SSH key'.
- Once the string is saved to the service, you should be good to go.   

#### b) VPS server, e.g. DigitalOCean, Vultr, Linode, etc.
The recommended way to add your public key to a VPS is through the command line, since trying to do this through
your hosting company's online UI often results in more trouble than it's worth.   
In your local terminal, it's as simple as:   
$ ssh-copy-id remote_username@remote_ip_address   
Use the -i flag for a non-default public key, e.g.:   
$ ssh-copy-id remote_username@remote_ip_address -i ~/.ssh/github_rsa.pub

Then check if everything went properly by logging in:  
$ ssh remote_username@remote_ip_address  
If everything went well, you will be logged in immediately.

**Note**:   
It's unsafe and considered bad practice to put your public key onto the remote machine's root user,
since this allows SSHing straight into the root.   
So do NOT execute:   
$ ssh-copy-id root@remote_ip_address  

Accessing the root user should be done by escalating privileges after SSHing
into the non-root user with sudo privileges, using either:   
$ su -   
$ sudo -i   
$ sudo 'command'

---------------------------------------------------------------------------------------------------------------------

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

