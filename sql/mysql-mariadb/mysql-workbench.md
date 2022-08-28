# MySQL Workbench
## Installation
* Go to [dev.mysql.com/downloads/mysql](https://dev.mysql.com/downloads/mysql/).
* Choose the proper installer, and **Go to download page**.
* Choose **mysql-installer-web-community**.
* At the bottom, click **No thanks, just start my download** (Oracle account is not required).
* Open the installer and allow it to make changes.
* When the installer window opens, choose `Custom` as Setup Type and click `Next`.
* Now we have to select the products we want to install. We select (then push the arrow that becomes green after selection):
  - `+` `MySQL Servers` > `MySQL Server` > `MySQL Server v.v` > **MySQL Server v.v.vv - X64**
  - `+` `Applications` > `MySQL Workbench` > `MySQL Workbench v.v` > **MySQL Workbench v.v.vv - X64**
  
  Click `Next` and then `Execute`. If `Visual C++` isn't yet installed, a popup will install that first. Click Next.

## Configuration
### MySQL Server
* Network settings are OK. Click `Next`.
* Choose **Use Legacy Authentication Method** for compatibility, and click `Next`.
* Choose a password for the **MySQL root account**, and click `Next`.
* Windows Service settings are OK. Click `Next`.
* Then click `Execute`, then `Finish`. After the final `Finish`, MySQL Workbench will be started.

### MySQL Workbench
* In the menu, choose Edit > Preferences.
* Select **SQL Editor** on the left, scroll all the way to the bottom, uncheck **Safe Updates** and click `OK`.
* Click `root` to log in to the **root account** and enter the password chosen above.

### Import Databases
* Click on the second SQL button (below Edit) to open an SQL file; select the correct `.sql` file and click `Open`.
* The script is now opened in a tab, so click the yellow lightning button to execute it.
* On the left side, click `Schemas`, and then the **Refresh button** next to the `Schemas` title. The new database will appear below!

## Execute an SQL instruction
* On the left are the imported databases. Double klick the one you need, and it will appear bold.
* Type the SQL query in the central tab named `Query 1`.
* Click the yellow lightning button to execute it.
* The yellow lightning button with the cursor only executes the query where the cursor is located, while the yellow lightning button with the magnifying glass shows the **execution plan** of the query, i.e. the steps that are taken when the query is executed. This is useful to compare efficiency of different queries; queries with less "Full Table Scan"s should be preferedd over those with more.

## Show database structure
* Menu > Database > Reverse Engineer ... (CTRL + R)
* Set Parameters for Connecting to a DBMS > Next
* Enter Password and hit Next.
* Select Schemas to Reverse Engineer: Choose the database(s) you want the structure of and hit Next.
* Enter Password and hit Next.
* Click Execute, then Next.
* Click Finish, and you'll get a tab named `EER Diagram`, which stands for **Enhanced Entity-Relationship diagram**. It provides a visual representation of the relationships among the tables in your model.