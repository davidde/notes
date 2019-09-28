# Useful BASH/Zshell commands

### $ `(sudo) adduser david`   
Create a new user named 'david'; you will be prompted to set and confirm the new user password:
```
Adding user `david' ...
Adding new group `david' (1000) ...
Adding new user `david' (1000) with group `david' ...
Creating home directory `/home/david' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
```
Then it will prompt you to set the new user’s information. If you want to leave all of this information blank just press ENTER to accept the defaults:
```
Changing the user information for david
Enter the new value, or press ENTER for the default
	Full Name []:
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n] y
```
If you want to add an existing user to an existing group, use:   
$ `sudo adduser [USER] [GROUP]`   
For example, to grant the previously created user sudo privileges:   
$ `sudo adduser david sudo`   
To revoke the sudo privileges:   
$ `sudo deluser david sudo`   

**Note:**   
Debian/Ubuntu's `adduser` was written with the purpose of being a convenient frontend to a range of utilities
(it makes use of, at one step or another, `useradd`, `usermod`, `gpasswd`, `passwd`, `chfn`, and a couple more commands).   
`adduser` and co are somewhat distro-specific in nature, being frontend scripts.   
Debian recommends that system administrators use `adduser`, `addgroup`, `deluser`, etc. over the more specific utilities.

### Android emulator:
* $ `~/Android/Sdk/emulator/emulator -list-avds`  
List the available emulators created with [Android Virtual Device Manager](https://flutter.dev/docs/get-started/install/linux#set-up-the-android-emulator).

* $ `~/Android/Sdk/emulator/emulator -avd @name-of-your-emulator`  
Run one of the listed emulators.

* $ `/opt/android-studio/bin/studio.sh`  
Launch the full Android Studio IDE.

### $ `apt-cache search [searchterm]`   
See which packages are available with 'searchterm'.

### $ `cat package.json`  
Show the content of the 'package.json' file.
 
* `cat >package.json`  
Create package.json from command line. This command will await input from user;  
after typing/copying text, press **CTRL+D** to exit.

* `cat file1.txt file2.txt`  
Concatenate file2.txt to file1.txt and print output.

* `cat *.VOB > moviename.vob; ffmpeg -i moviename.vob -acodec libfaac -ac 2 -ab 128k -vcodec libx264 -vpre fast -crf 20 -threads 0 moviename.mp4`  
Concatenate .vob dvd files, and then convert them to .mp4.

* `cat <(head -n 100 'Version1.srt') <(tail -n +101 'Version2.srt') > Version3.srt`  
Concatenate lines 101-end of Version2.srt to lines 1-100 of Version1.srt and store the result in Version3.srt.  
This example uses process substitution (`<` and parentheses `()` around subcommands) to feed
the stdout of the subcommands [head](#-head-pathtofile) and [tail](#-tail-pathtofile) to the stdin of `cat`.
It then redirects the stdout of `cat` to the file Version3.srt.  
See ahead for the specifics:

### `Pipe |` vs `Redirect >` vs `Process substitution <()`  
- A **redirect** is used to pass output to either a **file or stream**.  
E.g. `program > file.txt`  
If `file.txt` exists, it will be overwritten.   
If you want to append to `file.txt`, use:  
`program >> file.txt`   
If you want to pass the output from program1 to program2, you could do so with the following redirects:  
`program1 > temp_file.txt && program2 < temp_file.txt`  
But since this is so verbose, pipes were invented as a shortcut:  
`program1 | program2`
- So a **pipe** is used to pass output to another **program or utility**.  
E.g. `program1 | program2 | program3`
- However, what if you need to **pipe the stdout of multiple commands**?  
This is where **process substitution** comes in.  
Process substitution can feed the stdout of multiple processes into the stdin of another process:  
`program <(command1) <(command2)`  
Even though they look similar with the < and >, they are functionally entirely different from redirects!  
Also, process substitution does not allow spaces between the `<` and `()`.

### $ `chmod [permissions] [filepath]`   
chmod = **ch**ange **mod**e:   
Change the file mode / permissions for the file specified by 'filepath'.   
-R, --recursive: Also change permissions of files/directories inside the specified directory **and** its subdirectories.   
Example:   
$ `chmod -R 750 ~/projects/app`   
However, use the -R flag with care, since the default permissions for files and directories are not the same ...   
(You can use [find](./BASH.md#-find) combined with `chmod` to set different permissions for each.)   
See [chmod.md](./chmod.md) for a general introduction to linux file permissions.

### $ `chown -R  [username]:[groupname]  [filepath]`   
chown = **ch**ange **own**ership:   
Change ownership of the file/directory specified by 'filepath' to the specified 'username' and 'groupname'.   
Simply use `chown [username]` if you don't want to change group ownership.   
Use `chown [username]:`, note the left-out group, if you want to set the groupname
to the default group for that user.   
If you want to change only the group, you can use `chown :[groupname]`(note the left-out user).   
-R, --recursive: Also change ownership of files/directories inside the specified directory **and** its subdirectories.   
(Files/directories created in the future will not inherit the newly set 'username' or 'groupname',
but resort to the old ones specified by the system.)   
Example:   
$ `sudo chown -R david /www`   
This changes the ownership of /www (and its content) from the root user to david.   
If the directory is empty, the -R flag is pointless; it will not do anything for files yet to be created ...   
However, if you want newly created files/directories to inherit the group of its parent directory,
you can set the setgid bit on that parent directory:   
$ `chmod g+s [directory]`    

### $ `convert -background none -resize 64x64 g-logo.svg g-logo.ico`  
Use Imagemagick's convert utility to convert an `.svg` image to an `.ico` image.  
Drop the `-background none` if you want to modify the backgroundless `.svg` to white background `.ico`.  
Use the `-fill '#FF0000' -colorize 100` flag to color the image red, for example.

### $ `curl -i -X POST -d "isbn=978-1470184841&title=Metamorphosis&author=Franz Kafka&price=5.90" localhost:3000/books/create`  
curl = see url; it returns the content at the requested url  
-i: include http headers  
-X: Specify request command to use (e.g. POST, default is GET)  
-d: HTTP POST data

### $ `df -Th`  
Report file system disk space usage. Also useful for finding the mount points of all currently mounted file systems.  
You can also specify a path like so:   
$ `df -Th .`

### $ `diff -u [old_file] [new_file]`  
Check where the differences between 2 versions of a file are.  
(-u = unified diff format => easier to read.)

### $ `dpkg -s [packagename]`   
dpkg: Debian Package Manager   
Check the status (-s, --status) of the package named "packagename", i.e. is it installed, what does it do, etc.   
Make sure to use the official packagename, or it won't work. If not sure about the name, use:   
$ `apt-cache search [packagename]`   
This will list either the official name of your package or the official names of similar packages
if the packagename doesn't exist.

### $ `~/.dropbox-dist/dropboxd`  
Execute dropbox-daemon on Linux.

### $ `ffmpeg -i input.mov -acodec copy -vcodec copy output.mp4`  
Convert the video 'input.mov' to 'output.mp4'.

* $ `ffmpeg -i input.mov -vcodec libx264 -crf 24 output.mp4`  
Compress 'input.mov' with a constant rate factor of 24, and convert it to 'output.mp4'.

* $ `ffmpeg -i input.mp4 -b 1000000 output.mp4`  
Change the bitrate (quality) to 1000000 bytes/sec.
(Calculate the bitrate you need by dividing 1 GB by the video length in seconds.
So, for a video of length 16:40 (1000 seconds), use a bitrate of 1000000 bytes/sec.)  
Bitrate = video in bytes / length in seconds

* $ `ffmpeg -i input.gif output.mp4`  
$ `ffmpeg -i input.gif -b:v 0 -crf 25 output.mp4`  
$ `ffmpeg -i input.gif -c vp9 -b:v 0 -crf 41 output.webm`  
Convert an animated gif to `.mp4` or `.webm`.  
Video, especially `.webm`, is much more efficient to load on webpages than animated gifs.   
To replace an animated gif with video in html:   
  ```
  <video autoplay loop muted playsinline>
    <source src="oneDoesNotSimply.webm" type="video/webm">
    <source src="oneDoesNotSimply.mp4" type="video/mp4">
  </video>
  ```
  **Note:**  
  Browsers don't speculate about which `<source>` is optimal, so the order of `<source>`s matters. So if you specify an `.mp4` video first and the browser supports `.webm`, browsers will skip the `.webm <source>` and use the `.mp4` instead. If you prefer a `.webm <source>` be used first, specify it first!

### $ `find`   
Recursively finds all files/directories in the current directory and its subdirectories.   
You can specify another path to find items in, like so:   
$ `find app`   
This will return everything contained in the app directory (which should itself be in the current directory;
otherwise specify an absolute path).    
Some of find’s power comes from it’s ability to filter which files or directories it selects
with **'tests'**, and directly performing **'actions'** on the results:   

**Tests:**   
* -type: f (file) or d (directory)   
$ `find app -type f`   
Find all files in the app directory, including files in its subdirectories.   
* -maxdepth 1: Do not recurse into subdirectories.   
$ `find -type f -maxdepth 1`   
Find all files in the current directory, excluding files in its subdirectories.   
* -name: Takes a glob that will be matched against the base of the filename (filepath without leading directories).   
$ `find -name '*.ntl'`   
Find all files with the extension '.ntl' in the current working directory and its subdirectories.   
* -path: Same as -name, but applies to the whole filepath (including leading directories).   
* -regex: takes a regex pattern.   
* -amin 5: returns files last **a**ccessed less than 5 minutes ago.   
* -mmin 5: returns files last **m**odified less than 5 minutes ago.   
* -atime 5: returns files last **a**ccessed less than 5 days ago.   
* -mtime 5: returns files last **m**odified less than 5 days ago.   
* -user 'uname': returns files owned by user 'uname'.   
* -group 'gname': returns files owned by group 'gname'.   

**Actions:**   
* -delete: Deletes the files that were found. Be careful!   
First run without the -delete flag, so you see which files will be deleted.   
* -exec 'command': Executes 'command' on the files that were found.   
$ `find /www -type d -exec chmod 2750 {} \;`   
$ `find /www -type f -exec chmod 0640 {} \;`   
These examples combine find with the chmod command to set different permissions on the files vs directories
in the /www directory. `{}` is replaced by the file paths generated by find.
The semicolon `;` denotes the end of the command, but needs to be escaped with `\`,
otherwise it would be interpreted by the shell itself instead of find.

### $ `gatsby develop -H 0.0.0.0`  
Run gatsby develop from Local LAN.

### $ `gpasswd -a [USER] [GROUP]`   
Add the user 'USER' to the group 'GROUP' (~file permissions).   
To remove a user from a group, use:   
$ `sudo gpasswd -d [USER] [group]`   
Example:   
$ `sudo gpasswd -a david www-data`   
$ `sudo gpasswd -d david www-data`   
Or alternatively, use `adduser`:   
$ `sudo adduser david www-data`   
$ `sudo deluser david www-data`

### $ `grep -r 'StringToFind' .`  
Search for 'StringToFind' in all files in the current directory (.)  
-r, --recursive: Search recursively (i.e. also look in subdirectories)  
-R: Search recursively **and** follow all symbolic links.  
--exclude-dir: exclude the specified directories from being searched, e.g.:  
$ `grep -R --exclude-dir=node_modules 'StringToFind' [/path/to/search]`  
$ `grep -R --exclude-dir={node_modules,.cache} 'StringToFind' [/path/to/search]`

### $ `head path/to/file`  
Print the first 10 lines of the file. Opposite of [tail](#-tail-pathtofile).  
`-n [(-)num]`: Print the first `num` lines of the file.   
Head's output always starts at the start (head) of the file; the variable here is num:   
* Num by default measures from the head, i.e. start of the file.  
* Using `-` before the num lets num measure from the end of the file.   
This means the resulting output will be from the start of the file to `num` lines before the end of the file.

### Install more recent versions of software than what Debian 9 (stretch) provides by default, e.g. for newer git:  
$ `echo "deb http://ftp.debian.org/debian stretch-backports main" | sudo tee /etc/apt/sources.list.d/stretch-backports.list`  
$ `sudo apt update`  
$ `sudo apt install -t stretch-backports git`  
=> Backports will install the latest stable version of git instead of the one included in stretch.

### $ `ip a`  
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

### $ `java -jar briss-0.9.jar`  
(in directory where briss-0.9.jar is located; requires java)  
Start up briss, app to crop/resize/split pdfs.

### $ `ls -hal [/path/to/directory/or/file]`  
Show stats of the directory or file, including permissions (and which files for directories).  
-h (human-readable): Files sizes are displayed in the human-readable format of kilobytes and megabytes.  
-a (all): Display hidden files, including the directory itself, and its parent directory.  
-l (list): Display more information in a well-ordered list.  
=> On most systems, `ll` is an alias for `ls -lh` or `ls -la`, enter `type ll` to find out which.

### $ `mmv "long_name*.txt" "short_#1.txt"`  
Bulk rename all files in the current working directory such that the `#1` is replaced by
whatever is matched by the first wildcard `*`. Similarly `#2` is replaced by the second, etc. Quotes are necessary!  
**Options**:  
-n: no-execute mode; just print out the changes without actually making them.

So you do something like:   
$ `mmv "index*_type*.txt" "t#2_i#1.txt"`  
To rename 'index4_type9.txt' to 't9_i4.txt'.

E.g.:  
$ `mmv -n 'My.Awesome.Series.S01/Subs/My.Awesome.Series.S01E*/English.srt' 'My.Awesome.Series.S01/My.Awesome.Series.S01E#1-English.srt'`  
To move all subtitles from their separate folders into the main series folder, with adjusted names.

### $ `nvm`  
Node Version Manager: bash script used to manage multiple active Node.js versions.

* `nvm install --lts`  
Install the node LTS release. For another version, just replace the `--lts` with the specific version number:  
`nvm install 11.4.0`
* `nvm alias default 10`  
Set the default node version to 10 (2018's LTS).
* `nvm ls`  
List all installed node versions.
* `nvm use 11.4.0`  
Change the currently active node version to 11.4.0.

### $ `npm`  
Node Package Manager: the npm command line tool is used to manage and publish javascript packages to
[npmjs.com](https://www.npmjs.com/).

* `npm version [1.0.0]`  
	Set the version in `package.json` to 1.0.0, and create the corresponding
	[git commit](./git.md#-git-commit--a--m-description-of-changes)
	and **v1.0.0** [annotated tag](./git.md#-git-tag).  
	Rather than explicitly specifying a version number like above, it's better practice to use
	either of `patch`, `minor` or `major` to upgrade the relevant part:   

	* `npm version patch -m "Upgrade to %s for reasons"`   
		Upgrade 1.0.0 to 1.0.1 and specify a commit message; `%s` indicates the resulting version number 1.0.1.
	* `npm version minor -m "Upgrade to %s for reasons"`   
		Upgrade 1.0.0 to 1.1.0 and specify a commit message; `%s` indicates the resulting version number 1.1.0.
	* `npm version major -m "Upgrade to %s for reasons"`   
		Upgrade 1.0.0 to 2.0.0 and specify a commit message; `%s` indicates the resulting version number 2.0.0.

	**NOTE:**  
	Since tags are *not* automatically pushed to the remote, it's recommended to explicitly push them:  
	`git push --tags (origin master)`  
	Or, if you only want to push a single tag:  
	`git push origin v1.0.0`  

* `npm publish`   
Publish the package to npmjs. Make sure the version was upgraded with `npm version` before publishing.

### $ `qpdf -decrypt InputFile OutputFile`  
Remove protection/encryption from pdf files.

### $ `passwd`   
Change the password for the current user.   
To change the password of root:   
  - Login to root with either `su -` or `sudo -i`.   
  - Change the password with `passwd`.
  - Log back out using **CTRL + D**, `exit` or `su - username`.
  - Test logging in with new password: `su -` or `sudo -i`.   

### $ `rename`   
Rename is a powerful command that fully supports Perl [regular expressions](./regex.md).  
If the full power of regexes is not required, the [mmv](#-mmv-long_nametxt-short_1txt) command
might be considerably simpler.

There are several versions of rename in circulation:  
- **Debian/Ubuntu Perl-based version** of rename by Larry Wall & Robin Barker,
named `prename` on CentOS and Fedora.
- **Mac version** of rename by Aristotle Pagaltzis; this is a newer implementation of
Debian's version by Larry Wall, which it is backwards compatible with.  
This means the Mac version understands e.g. `rename 's/.rar/.cbr/' *.rar`,
but Debian's version does not have the newer Mac -S flag.
- There is still another 'rename' in use on older Red Hat and CentOS distributions.

Examples:  
#### 1) Bulk rename all files in the current working directory from .rar to .cbr:
These Debian commands will work on Mac, but not the other way around!
* Debian:  
`rename -n 's/.rar/.cbr/' *.rar`  
-n, -nono: no-execute mode; just print out the changes without actually making them.  
-v, -verbose: Print names of files successfully renamed.  

* Mac:  
`rename -S .rar .cbr *.rar`  
-s, --subst: Perform a simple textual substitution of "from" to "to".
The "from" and "to" parameters must immediately follow the argument.  
-S, --subst-all: Same as "-s", but replaces every instance of the "from"
text by the "to" text.  
-n, --dry-run, --just-print: no-execute mode; just print out the changes without actually making them.  
-v, --verbose: Print additional information about the operations (not) executed.

* BASH:  
	```
	$ for file in *.rar  
			$ do  
			$ mv "$file" "${file%.rar}.cbr"  
			$ done
	```

#### 2) Bulk rename all .txt files in current directory to have spaces before uppercase letters:
* Debian:   
`rename -n 's/([A-Z])/ $1/g' *.txt`  
`rename -n 's/(?<=\w)(?=[A-Z])/ /g' *.txt`  
The second, more complex command will *not* add a space before the first letter of the filename if it is uppercase.


#### 3) Remove the text 'useless_prefix_' from filenames/directories:  
* Debian:  
`rename -n 's/useless_prefix_//' *`  
* Mac:  
`rename -nS useless_prefix_ '' *`  

### $ `rm -rf /path/to/directory`    
Remove the directory **and** all its contents.   
-f, --force: ignore nonexistent files and arguments, never prompt.   
-r, -R, --recursive: remove directories and their contents recursively.

### $ `scp /path/to/local/file remote_username@remote_server:/path/to/remote/destination`   
Securely copy a local file to a remote server over SSH.   
For the reverse, copying a remote file to your local machine, use the command with the paths reversed:   
`scp remote_username@remote_server:/path/to/remote/file /path/to/local/destination`   
**-r**: Recursively copy entire directories, e.g.:   
`scp -r /path/to/local/directory remote_username@remote_server:/path/to/remote/destination`

### $ `ssh remote_username@remote_ipaddress (-i /path/to/privatekey)`    
SSH into the server with IP address 'remote_ipaddress' as user 'remote_username'.  
If your username is the same locally and on the server, you can leave it out:  
`ssh ipaddress`  
-i: Only required when using a private key not named '~/.ssh/id_rsa'.  
-p: Port to connect to on the remote host. Only required when it's a non-standard port number for ssh.   
-vvv: verbosity, useful for debugging.   
Enter `exit` or press **CTRL + D** to exit the remote server.   
See [SSH.md](./SSH.md) for a general introduction to SSH.

### $ `su - david`  
Switch to the user 'david' (su = **s**witch **u**ser). You can also switch to the root user
by invoking the command with no parameter. Unlike `sudo`, `su` asks you for the password of the user you switch to.   
Note `su -` here:  
`su -` invokes a login shell after switching the user, which resets most environment variables, providing a clean base.   
`su` just switches the user, providing a normal shell with an environment nearly the same as with the old user.   
This means it's generally safest to use `su -`.

### $ `sudo [command]`   
`sudo` is meant to run a single command with root privileges. 
Unlike `su` it prompts you for the password of the current user. This user must be in the sudoers file (`/etc/sudoers`),
or a group that is in the sudoers file. By default, Ubuntu "remembers" your password for 15 minutes,
so that you don't have to type your password every time.

### $ `sudo apt -f install`  
-f: 'fix broken'  
Fix broken dependencies.

### $ `sudo apt remove [package-name]`  
Remove a package from your system, but keep the configuration files, plugins and settings.
This helps in keeping the same settings when you want to reinstall the software.

### $ `sudo apt purge [package-name]`  
Remove a package completely from your system, including any personalized configuration files and settings.

### $ `sudo apt update`  
This will update your system's packages index (located in `/etc/apt/sources.list` for sytem defaults,
and `/etc/apt/sources.list.d/` for user-added sources). It will list all packages the index contains.  
If updates are available for a package, it will be listed behind it as `[x kB]`.  
You can then update any of these packages by simply reinstalling them, e.g.:  
`sudo apt install code`  
This will install a new version of vscode from the packages index.

### $ `sudo apt dist-upgrade`  
Upgrade your machine by installing the newest versions of all packages currently installed on
the system from the sources enumerated in /etc/apt/sources.list.
An update must be performed first so that apt knows that new versions of packages are available.

### $ `sudo apt update && time sudo apt dist-upgrade`  
Update package lists and upgrade your machine while timing it.

### $ `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys [PUBKEY]`  
Fix the GPG error 'NO_PUBKEY', for example when adding a ppa to your system.  
When you run `sudo apt update` with this ppa error, you will get;  
`W: GPG error: http://ppa.launchpad.net trusty Release:  
The following signatures couldn't be verified because the public key  
is not available: NO_PUBKEY 93C4A3FD7BB9C367`,  
where `93C4A3FD7BB9C367` is the 'PUBKEY' you need to use in the command.

### $ `sudo cat /etc/sudoers`   
Print out the sudoers file; this file contains the rules that users must follow when using the sudo command.
You should never edit it directly, but use the `visudo` command (< vi + sudo):   
`visudo`   
Check the man pages for extra info on the sudoers file / vi(m) / visudo:   
`man sudoers`   
`man vi`   
`man visudo`

### $ `sudo fs_usage | grep [path_to_file]`  
Find out which application is touching the file.

### $ `sudo kill -9 [PID]`  
Kill process with PID.

### $ `sudo lsof -i :8000`  
Detect what process is listening to (and occupying) port 8000.


### $ `tail path/to/file`  
Print the last 10 lines of the file. Opposite of [head](#-head-pathtofile).  
`-n [(+)num]`: Print the last `num` lines of the file.   
Tail's output always ends at the end (tail) of the file; the variable here is num:   
- Num by default measures from the tail, i.e. end of the file.  
- Using `+` before the num lets num measure from the start of the file.  
So when using `+num`, output starts at line `num` to the end of the file (instead of num lines *from* the end).   

`-f, --follow`: Follow the file interactively as it grows.  
This is really useful for monitoring log files to troubleshoot:  

* `tail -f *.log`  
Follows (-f) all log files, so you can track potential issues.

More specific logs:  
* `tail -f /var/log/kern.log`   
// kernel-only, i.e. dmesg output

* `tail -f /var/log/syslog`     
// kernel + programs

### $ `tar xf file.tar.gz -C /path/to/directory`  
Unpack a gunzip compressed tar file.  
x: Extract the files.  
f: Specify a filename to unpack.  
(z: Uncompress the gzip file; usually no longer required.)  
(v: `verbose`; lists all of the files one by one in the archive.)  
-C: Specify the directory to unpack to (default is current directory).

### $ `touch file.txt`  
Create an empty file called 'file.txt'.

### $ `tree -H . > contents.html`
The `tree` command prints a tree diagram of the current directory structure to the terminal.  
`> contents.html` pipes the output to the file contents.html.  
`-H [href]`: print output in HTML form.
