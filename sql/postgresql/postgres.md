# How to set up a PostgreSQL database

We will now set up a PostgreSQL database by borrowing the database from the excellent book
'Sams Teach Yourself SQL in 10 Minutes (4th edition)'.
The SQL files should be present in this repository.

1. $ `sudo apt install postgresql postgresql-contrib`

2. $ `sudo su postgres`  
Log in to the default postgres account

3. $ `createuser (-d -e -P) sams`  
Create the database user; when not specifying any flags (or when specifying
 --interactive), you will be prompted with several questions
(like making the user superuser, etc.)  
-d: user can create databases  
-e: echo commands  
-P: with password (you will be prompted to enter it)  
To delete the database user, enter:  
$ `dropuser sams`

4. $ `createdb sams`  
Create the database for the sams user. For simplicity's sake, we use the default
sams database for our sams database user. (So they have to have the same names.)

5. $ `psql -f _sams-sql-4th-postgres-create.sql -d sams -U sams`  
$ `psql -f _sams-sql-4th-postgres-populate.sql -d sams -U sams`  
Create the database by executing the create and populate scripts, which, as their name suggests,
create the actual database tables and populate the created database with data.  
-f: execute commands from file, then exit.  
-d: specify database  
-U: specify user  

6. $ `psql sams`  
Login to the sams database. An interactive shell showing the database name should appear:  
sams=>   
To login to the sams database as root user postgres, use:   
$ `psql -U postgres -d sams`  

7. PSQL Commands:  
sams=> `\l`: list all databases  
sams=> `\c database`: connect to 'database'  
sams=> `\dt`: list all tables in the current database  
sams=> `\du`: list all users in the current database   
sams=> `\d table_name`: show all columns in the table
