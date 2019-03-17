# File permissions and ownership
## $ `chmod [permissions] [filepath]`   
chmod = **ch**ange **mod**e:   
Change the file mode/permissions of the file/directory specified by 'filepath'.   
-R, --recursive: Also change permissions of files/directories inside the specified directory **and** its subdirectories.   
Example:   
$ `chmod -R 750 ~/projects/app`   
However, use the -R flag with care, since the default permissions for files and directories are not the same ...   
(You can use [find](./BASH.md#-find) combined with `chmod` to set different permissions for each.)

### Permissions: read (r), write (w), execute (x)
* Read: Allows files to be read.
* Write: Allows files to be written.
* Execute: Allows binary files to be executed, and directories to be entered/searched.
For example, if a directory has no execute permission, you cannot use the cd command to "change directory" into it,
nor can you list its contents.

Permissions can be specified in either **symbolic or octal notation**;    
since they are internally set as bits, the conversion from symbolic to octal is straightforward:   
rwx in symbolic = 111 in binary = 4+2+1 in octal = 7   
rw‒ in symbolic = 110 in binary = 4+2+0 in octal = 6   
r‒x in symbolic = 101 in binary = 4+0+1 in octal = 5   
r‒‒ in symbolic = 100 in binary = 4+0+0 in octal = 4   
‒wx in symbolic = 021 in binary = 0+2+1 in octal = 3   
‒w‒ in symbolic = 010 in binary = 0+2+0 in octal = 2   
‒‒x in symbolic = 001 in binary = 0+0+1 in octal = 1   

Default permissions:   

|    Filetype        |   symbolic   |   octal    |
|--------------------|--------------|------------|
|   **Files**        |  ‒rw‒r‒‒r‒‒  |   0644     |
|   **Directories**  |  drwxr‒xr‒x  |   0755     |

Use `ls -l` or `ll` to verify permissions.

### Symbolic notation
Symbolic notation uses either +/- r/w/x to add/restrict read/write/execute permissions, e.g.:   
$ `chmod -x $(find -name '*.ntl')`  
Change the permissions by restricting execution (-x) for all files ending in '.ntl'.  
=> This is necessary for example to have Python read them as text-type instead of binary-type on Mac.   
`chmod +x` would allow execution; be aware though that `+x` sets the execute bits of the user, group *and* other.  
If you wish to set the execute bit more specifically, use:   
  $ `chmod u+x [filename]` to set the execute bit for the user.   
  $ `chmod g+x [filename]` to set the execute bit for the group.   
  $ `chmod o+x [filename]` to set the execute bit for other.   

### Octal notation
Octal notation uses a 4 number format to denote which permissions bits are set for the user,
group and other: 0UGO.   
* The leading 0 denotes octal, but can also be used for setting **special modes** (see ahead).
This leading 0 has no special significance and can be left out;   
$ `chmod 0755 foo.sh` = $ `chmod 755 foo.sh`   
* The second number (or first when the leading 0 is left out) indicates the permission bits of the **user**.
* The third number indicates the permission bits of the **group**.
* The fourth number indicates the permission bits of **other**.

### Classification of Users: user, group and other
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

### Special Modes
* **setuid**: Binary executables with the setuid bit can be executed with the privileges of the file's owner.   
Due to it's nature it should be used with care. It has no effect if the user does not have execute permissions.
  - Symbolic notation: u+s (also represented as 's' in the output of ls, or 'S' when it has no effect)   
  $ `chmod u+s foo.sh`
  - Octal notation: 4000   
  $ `chmod 4755 foo.sh`
  - Resulting permissions:   
  ‒rw**s**r‒xr‒x

* **setgid**: Binary executables with the setgid bit can be executed with the privileges of the file's group.   
A useful property is to **set the setgid bit on a directory so that all files and directories newly created
within it inherit the group from that directory**. setgid has no effect if the group does not have execute permissions.
  - Symbolic notation: g+s (also represented as 's' in the output of ls, or 'S' when it has no effect)   
  $ `chmod g+s foo.sh`
  - Octal notation: 2000   
  $ `chmod 2755 foo.sh`
  - Resulting permissions:   
  ‒rwxr‒**s**r‒x

* **Sticky bit**: The sticky bit is most commonly used on directories where it allows the files or directories within
to only be moved or deleted by that object's owner, the directory owner, or the superuser.
The sticky bit has no effect if other does not have execute permissions.
  - Symbolic notation: +t (also represented as 't' in the output of ls, or 'T' when it has no effect)   
  $ `chmod +t foo.sh`
  - Octal notation: 1000   
  $ `chmod 1755 foo.sh`
  - Resulting permissions:   
  ‒rwxr‒xr‒**t**

These special modes can also be combined, e.g. 7000 sets all the special bits: $ `chmod 7755 foo.sh`.   
To clear/remove the special bits, use either '-' in symbolic notation, e.g. $ `chmod g-s foo.sh`,
or 2 leading '0' in octal notation: $ `chmod 00755 foo.sh` to unset them all.

Check out the [chmod permissions calculator](http://permissions-calculator.org/) to better visualise file permissions.

## $ `chown -R  [username]:[groupname]  [filepath]`   
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
