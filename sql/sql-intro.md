# Intro to Relational Databases
## Intro
* How do we structure application data?

  |     In memory:                           |     Durable storage:                    |
  |------------------------------------------|-----------------------------------------|
  | **Simple variables**: numbers, strings   | **Flat files on disk**: text, xml, json |
  |                                          |                                         |
  | **Data structures**: lists, dictionaries | **Databases**: key-value store          |
  |                                          |                                         |
  | = EPHEMERAL/TEMPORARY                    | = PERSISTANT/DURABLE                    |

* All databases provide:
    - persistent storage
    - safe concurrent access by multiple programs/users

* On top of that, relational databases like SQL also provide:
    - a flexible query language with **aggregation** and **join operations**
    - constraints: rules for protecting the consistency of your data

* SQL jargon:
  - **Table or Entity**: 2-dimensional data structure made of rows and columns
  - **Row, Record or Instance**: Contains data that belongs together.
  - **Column or Attribute**: Contains data of the same type.
  - **Field**: Intersection of a row and column; contains specific information of a specific thing.
  - **Primary Key**: Field that uniquely defines a record.
  - **Foreign Key**: the link that connects 2 tables.
  - **Index**: like the index in a book; with a search word you can find the correct record in a table, e.g. the column that contains family names.
  - **collation**: The comparison and sorting of characters depends on the specific **collation** of the database server. The standard collation of MySQL does not distinguish between lower and upper case. This means the following are equivalent in standard MySQL:
    ```
    WHERE name='Tom'
    WHERE name='tom'
    ```

* Common **aggregation** functions in SQL:   
(An aggregation function 'aggregates' data from all rows,
and returns a single result value)

  |     Question                   |     Aggregation    |
  |--------------------------------|--------------------|
  | How many rows have this value? |      count         |
  | What's the average value?      |      avg           |
  | What's the greatest value?     |      max           |
  | What's the smallest value?     |      min           |
  | What's the sum?                |      sum           |

  For example:
  ```sql
  SELECT count(*) AS number FROM animals
  ```
  This will return the total number of records in the animals table, giving it the alias number. `count(*)` is used frequently because **aggregate functions do not take into account the value NULL**! This means that in the following example:
  ```sql
  SELECT count(name) FROM animals
  ```
  Animals that were not named (have NULL for name) aren't taken into account, meaning this may result in less than the total number of records/animals. This is why `count` is usually combined with `*` in practice.

## Datatypes in SQL
### Text and string types
* text: string of any length, like Python str or unicodetypes.
* char(n): string of exactly n characters.
* varchar(n): string of up to n characters.

### Numeric types
* integer: integer value, like Python int.
* real: floating-point value, like Python float.  
Accurate up to six decimal places.
* double precision: higher-precision floating-point value.  
Accurate up to 15 decimal places.
* decimal: exact decimal value.

### Date and time types
* date: a calendar date; including year, month, and day.
* time: a time of day.
* timestamp: a date and time together.

## SQL code for the tables in the examples
```sql
CREATE TABLE animals (
    name text,
    species text,
    birthdate date,
);

CREATE TABLE diet (
    species text,
    food text,
);

CREATE TABLE taxonomy (
    name text,
    species text,
    genus text,
    family text,
    t_order text,
);

CREATE TABLE ordernames (
    t_order text,
    name text,
);
```
Remember:  
- In SQL, we always put string **and date values** inside 'single' quotes.
- By convention, SQL keywords are written in **ALL CAPS** so they can easily be distinguished visually from the tables and other variables.

## Predicates
### DISTINCT
```sql
SELECT DISTINCT species FROM animals
```
Will return all the species from the animals table. The `DISTINCT` predicate ensures that the returned subset consists of unique species; without it, the subset may contain a single species multiple times if there are several animals from the same species in the table.

By default the predicate `ALL` is used, so it does not need to be typed.

## SELECT statement and select clauses
The `SELECT` statement can express arbitrary complex searches and aggregations of data; it uses **select clauses** like `where`, `limit` and `order`/`group by` for more specific searches.  
E.g. QUERY = "SELECT * FROM animals where species = 'orangutan' order by birthdate;"  
The result of a query is always a **(subset) table**.

### WHERE ...
The `WHERE` clause expresses restrictions — filtering a table for rows that follow a particular rule. `WHERE` supports equalities, inequalities, and boolean operators, e.g.:
* `WHERE species = 'gorilla'`  
Return only rows that have 'gorilla' as the value of the species column.
* `WHERE name >= 'George'`  
Return only rows where the name column is alphabetically after 'George'.
* `WHERE species <> 'gorilla' AND name <> 'George'`  
Return only rows where species isn't 'gorilla' and name isn't 'George'.


#### Operators used with WHERE: <, >, <=, >=, <>, =, LIKE, BETWEEN ... AND ... , IN (...)
* `LIKE` has a few special options like:
  - `%` which represents an arbitrary number of characters.  
    E.g. `SELECT species FROM animals WHERE species like '%fish%'`  
    This would return for instance 'goldfish' and 'kingfisher', as well as 'fishxyz'.
  - `_` represents 1 arbitrary character.  

* `SELECT name FROM beers WHERE alcohol IS NULL`  
  This will return all beers where the alcohol percentage was not entered. Note the use of `IS` instead of `=` when `NULL` is involved!
* `SELECT name FROM beers WHERE alcohol BETWEEN 5 AND 7`
* `SELECT name FROM beers WHERE alcohol IN (0, 5, 8)`  
  With the operator IN you can group together different **OR conditions** (i.e. WHERE alcohol = 0 OR alcohol = 5 OR alcohol = 8).


### LIMIT ... (OFFSET ...)
The `LIMIT` clause sets a limit on how many rows to return in the result table. The optional `OFFSET` clause says how far to skip ahead into the results.  
E.g. `LIMIT 10 OFFSET 100`  
Return 10 results starting with the 101st.

### ORDER BY ... (DESC)
The `order by` clause tells the database how to sort the results — usually according to one or more columns. Ordering happens before `LIMIT`/`OFFSET`, so you can use them together to extract pages of alphabetized results.  
E.g. `ORDER BY species, name`  
Sort results first by the species column, then by name within each species.

The optional `DESC` modifier tells the database to order results in descending order, for instance from large numbers to small ones, or from Z to A. (There is also an `ASC` modifier that orders in ascending order, but this is the default sorting order.)

### GROUP BY ...
The `GROUP BY` clause is only used with aggregations, such as `max`, `count` or `sum`. Without a `GROUP BY` clause, a select statement with an aggregation will aggregate over the whole selected table(s), returning only one row. With a `GROUP BY` clause, it will return one row for each distinct value of the column or expression in the group by clause.

For example:
```sql
SELECT species, min(birthdate) FROM animals GROUP BY species
```
This will return a table with 2 columns; the first with all the species, and the second with the birthdates of the oldest animal of that species.  
**-> Contrast this with:**  
```sql
SELECT species, min(birthdate) FROM animals
```
This will return only a single row of 2 columns; the species and the birthdate of the oldest animal.

> **Note**  
> When using `GROUP BY` all columns that appear in the `SELECT` clause and are **NOT** a part of an aggregate function should be part of the `GROUP BY`. (E.g species in the above `GROUP BY` example.)

SQL also has a `round` function: `round(price, 1)` will round the `price` column to 1 number after the decimal. This is useful for instance to count all products that have a certain integer price point:
```sql
SELECT round(price, 0) as rounded_price, count(*) as amount
FROM products
GROUP BY rounded_price
ORDER BY amount ASC
```

## HAVING clause
The `HAVING` clause works like the `WHERE` clause, but it applies after `GROUP BY` aggregations take place. The syntax is like this:
```sql
SELECT columns FROM tables GROUP BY column HAVING condition
```
Usually, at least one of the columns will be an aggregate function such as `count`, `max`, or `sum` on one of the tables' columns. In order to apply `HAVING` to an aggregated column, you'll want to give it a name using `AS`.

For instance, if you had a table of items sold in a store, and you wanted to find all the items that have sold more than five units, you could use:
```sql
SELECT name, count(*) AS num FROM sales HAVING num > 5
```
You can have a `SELECT` statement that uses only `WHERE`, or only `GROUP BY`, or `GROUP BY` and `HAVING`, or `WHERE` and `GROUP BY`, or all three of them!

But it doesn't usually make sense to use `HAVING` without `GROUP BY`.

If you use both `WHERE` and `HAVING`, the `WHERE` condition will filter the rows that are going into the aggregation, and the `HAVING` condition will filter the rows that come out of it.

`HAVING` is different from `WHERE`: `WHERE` filters individual rows before the application of `GROUP BY`, while `HAVING` filters group rows created by `GROUP BY`.

> **In short:**  
> You use `HAVING` if the selection is based on the result of an aggregate function.  
> In all other cases you use `WHERE`.  
> 
> You can read more about `HAVING` [here](http://www.postgresql.org/docs/9.4/static/sql-select.html#SQL-HAVING).

* **Question:** Which species does the zoo have only one of?
WRONG:
```sql
SELECT species, count(*) AS num
    FROM animals GROUP BY species
    WHERE num = 1;
```
This is wrong because the value of num comes from count and `GROUP BY`, but `WHERE` always runs **BEFORE** aggregations!  
We can correct this by changing a single word:
```sql
SELECT species, count(*) AS num
    FROM animals GROUP BY species
    HAVING num = 1;
```

Examples:
* Determine the minimum alcohol percentage for every `brouwerNr`. The result should only show the `brouwerNr`s and percentages smaller than 5%.
  ```sql
  SELECT brouwerNr, min(alcohol) as min FROM bieren
  GROUP BY brouwerNr HAVING min < 5
  ORDER BY brouwerNr
  ```

* Calculate the average alcohol percentage for each brouwerNr for which the brewery produces more than 10 beers.
  ```sql
  SELECT brouwerNr, avg(alcohol) as avg FROM bieren
  GROUP BY brouwerNr HAVING count(*) > 10
  ORDER BY brouwerNr
  ```

## JOIN statement
In practice it often happens you need data from more than 1 table. Therefore you can make queries that join one table to another and select the correct data from it.
To join two tables:  
- choose the **join condition**, i.e. the rule you want the database to use to match up rows from one table with rows from the other table.
- write a join in terms of the columns in each table.

E.g. Find the **names** of all individual animals that eat fish  
(**animals columns**: name, species, birthdate)  
(**diet columns**: species, food)  

**-> Problem:** the animals table tells us nothing about what each animal eats, and the diet table doesn't list individual animals, ... only species.

**-> Solution:** the species column is in both the animals and diet tables, so we can do a 'join' between both tables:
```sql
SELECT animals.name
FROM animals JOIN diet
ON animals.species = diet.species
WHERE food = 'fish'
```
**join condition:** on animals.species = diet.species  

Alternatively, we can use simple join syntax:
```sql
SELECT name FROM animals, diet
WHERE animals.species = diet.species
AND diet.food = 'fish'
```

* **Question:** Which food is eaten by only one individual animal?

There are a few different ways to solve this, but here's one of them:
```sql
SELECT food, count(animals.name) AS num
    FROM diet JOIN animals
    ON diet.species = animals.species
    GROUP BY food
    HAVING num = 1;
```

And here is another:
```sql
SELECT food, count(animals.name) AS num
    FROM diet, animals
    WHERE diet.species = animals.species
    GROUP BY food
    HAVING num = 1;
```

### INNER JOIN
With an `INNER JOIN` you can combine records from 2 or more tables based on a condition with fields from different tables. Records from either table that do not have a corresponding record in the other table, will not be shown.

You can apply it on every `FROM` component. The `INNER JOIN` is the most used type of join.

For example:  
We have 2 tables:
* Jobs:

  | jobId | Description | personId |
  |-------|-------------|----------|
  | 1     | washing     | 3        |
  | 2     | drying      | 1        |
  | 3     | storing     | NULL     |

* Persons:

  | personId | Name        |
  |----------|-------------|
  | 1        | Miko        |
  | 2        | Ian         |
  | 3        | Fred        |

In an INNER JOIN a row from one table only gets into the result if there is a corresponding row in the other table:
```sql
SELECT description, name FROM jobs INNER JOIN persons
ON jobs.personId = persons.personId
```
Result:  

| Description | Name        |
|-------------|-------------|
| Drying      | Miko        |
| Washing     | Fred        |

### (OUTER) JOIN
With an `OUTER JOIN` you can combine records from 2 or more tables based on similar values in a common field:
* With the command `LEFT JOIN` you create a **LEFT OUTER JOIN**. In a LEFT OUTER JOIN all records from the first (left) table are used, even if there are no corresponding values in the second (right) table.
* With the command `RIGHT JOIN` you create a **RIGHT OUTER JOIN**. In a RIGHT OUTER JOIN all records from the second (right) table are used, even if there are no corresponding values in the first (left) table.

Examples:  
* ```sql
  SELECT description, name FROM jobs LEFT JOIN persons
  ON jobs.personId = persons.personId
  ```
  Result:

  | Description | Name        |
  |-------------|-------------|
  | Drying      | Miko        |
  | Washing     | Fred        |
  | Storing     | NULL        |

* ```sql
  SELECT description, name FROM jobs RIGHT JOIN persons
  ON jobs.personId = persons.personId
  ```
  Result:

  | Description | Name        |
  |-------------|-------------|
  | Drying      | Miko        |
  | NULL        | Ian         |
  | Washing     | Fred        |

* Give an overview of all `leveranciers` and their accompanying `bestellingen`. Also show the `leveranciers` with whom we haven't ordered anything yet. Only show the fields `bestelId` and `leverancierNaam`.
  ```sql
  SELECT leverancierNaam, bestelId
  FROM bestellingen RIGHT JOIN leveranciers
  ON bestellingen.leverancierId = leveranciers.leverancierId
  ORDER BY bestelId
  ```
  This is identical to:
  ```sql
  SELECT leverancierNaam, bestelId
  FROM leveranciers LEFT JOIN bestellingen
  ON leveranciers.leverancierId = bestellingen.leverancierId
  ORDER BY bestelId
  ```

> **INNER vs OUTER JOIN**  
> In SQL, a join is used to compare and combine — literally join — and return specific rows of data from two or more tables in a database. An **INNER JOIN** finds and returns matching data from tables, while an **OUTER JOIN** finds and returns matching data *and some dissimilar data* from tables.

### SELF JOIN
A `SELF JOIN` is an INNER JOIN or OUTER JOIN that uses the same table twice. In order to do this, you need to give the table 2 different aliases.

* Make a list of all `brouwers` that live in the same `gemeente`. To the table `brouwers` we give each time an alias. If you use a column name, you also need to use the alias to specify from which table.
  ```sql
  SELECT b1.brnaam, b2.brnaam, b1.gemeente
  FROM brouwers as b1 INNER JOIN brouwers as b2
  ON b1.gemeente = b2.gemeente AND b1.brouwernr < b2.brouwernr
  ORDER BY b1.gemeente
  ```
  `b1.brouwernr < b2.brouwernr` makes sure that combinations like Artois–Artois and double records like Artois–Domus and Domus–Artois are avoided.

* Find the `bestellingen` that have a `besteldatum` that equals the `leveringsdatum` from one or more other `bestellingen`. Give `bestelId` of the first delivery, `besteldatum` of the first delivery, `bestelId` of the second delivery, and `leveringsdatum` of the second delivery.
  ```sql
  SELECT b1.bestelId AS id1, b1.bestelDatum AS bestelDat1, b2.bestelId AS id2, b2.leveringsDatum AS leverDat2
  FROM bestellingen AS b1
  INNER JOIN bestellingen AS b2
  ON b1.bestelDatum = b2.leveringsDatum
  ```

## UNION
With a UNION you can combine the results from any 2 or more SELECT instructions.

Rules:

* All SELECT queries in a UNION need to get the same number of fields, even though they do not need the same length or data type.
* Aliases are only possible for the first SELECT, and are ignored in the latter.
* For sorting with ORDER BY you should reference the fields from the first SELECT component. ORDER BY is placed at the end of the entire UNION.
* Double results are not shown by default in a UNION. If you want to show them, use UNION ALL.

**Example:**  
Create a list of all beers, giving them a label from one of the following: alcohol-free (<0,2), low alcohol (<0,5), contains alcohol (>0,5) and unknown (IS NULL). Sort by alcohol percentage.
```sql
SELECT naam, alcohol, 'alcohol-free' AS label
FROM bieren WHERE alcohol<0.2
UNION
SELECT naam, alcohol, 'low alcohol' AS label
FROM bieren WHERE alcohol>=0.2 and alcohol <0.5
UNION
SELECT naam, alcohol, 'contains alcohol' AS label
FROM bieren WHERE alcohol>=0.5
UNION
SELECT naam, alcohol, 'unknown' AS label
FROM bieren WHERE alcohol IS NULL
ORDER BY alcohol
```

## SUBQUERIES
Examples:

* Give a list of all beers with the highest alcohol percentage.
  ```sql
  SELECT naam FROM bieren
  WHERE alcohol = (SELECT max(alcohol) FROM bieren)
  ```
  When using a relation operator like =, <, >, >=, <= and <>, the subquery can only give 1 result.

* Give a list of all beers that are brewn in Oudenaarde.
  ```sql
  SELECT naam FROM bieren
  WHERE brouwerNr in
  (SELECT brouwerNr FROM brouwers
  WHERE gemeente = 'Oudenaarde')
  ```

* Give the `soortNr` of the `soorten` that are only brewn by 1 brewery.
  ```sql
  SELECT soortNr FROM
  (SELECT DISTINCT soortNr, brouwerNr FROM bieren) AS list
  GROUP BY soortNr
  HAVING count(*)=1
  ```
  A subquery in a FROM component needs to have an alias.

* Make a list with the average alcohol percentage per `soort`.
  ```sql
  SELECT soort, gemiddelde
  FROM (SELECT soortnr, avg(alcohol) as gemiddelde
    FROM bieren GROUP BY soortnr) as r1
  INNER JOIN soorten
  ON r1.soortnr = soorten.soortnr
  ```

* Make a list of all beers with a lower alcohol percentage than the average alcohol percentage of its own `soort`.
  ```sql
  SELECT b1.* FROM bieren as b1
  WHERE b1.alcohol <
  (SELECT avg(b2.alcohol) FROM bieren as b2
  WHERE b2.soortnr=b1.soortnr)
  ```
  This uses the table `bieren` twice, so it uses aliases to distinguish the fields.

## INSERT statement
The basic syntax for the `INSERT` statement:
```sql
INSERT INTO table ( column1, column2, ... ) VALUES ( val1, val2, ... );
```
If the values are in the same order as the table's columns (starting with the first column), you don't have to specify the columns in the insert statement:
```sql
INSERT INTO table VALUES ( val1, val2, ... );
```
For instance, if a table has three columns (a, b, c) and you want to insert into a and b, you can leave off the column names from the `INSERT` statement.
But if you want to insert into b and c, or a and c, you have to specify the columns.

A single `INSERT` statement can only insert into a single table. (Contrast this with the SELECT statement, which can pull data from several tables using a JOIN.)

Examples:
1. Add a new soort 'Extra donker' to the table 'soorten'.
    ```sql
    INSERT INTO soorten (Soort)
    VALUES ('Extra donker')
    ```
    Because `SoortNr` is a field that is indexed automatically, we do not need to add it in our SQL instruction; it will be assigned automatically.

2. Add a new 'brouwer' to the table `brouwers`.
   Data of the new brouwer: Brouwerij Vaattappers is located at Interleuvenlaan 2 in 3000 Heverlee and has an `omzet` of 1000.
    ```sql
    INSERT INTO brouwers (brNaam, adres, postcode, gemeente, omzet)
    VALUES ('Brouwerij Vaattappers', 'Interleuvenlaan 2', 3000, 'Heverlee', 1000)
    ```
    Here also BrouwerNr is not added to the SQL instruction because it is numbered automatically.

3. Add 3 new kinds of beer to the table `soorten`: witbier, Ice bier and honing bier.
    ```sql
    INSERT INTO soorten (Soort)
    VALUES ('witbier'),
    ('Ice bier'),
    ('honing bier')
    ```
    Again, `SoortNr` is not used because it is numbered automatically.
    
4. Add all beers with an alcohol percentage higher than 10 to the table `bieren_oud`.
    ```sql
    INSERT INTO bieren_oud
    SELECT * FROM bieren
    WHERE alcohol > 10
    ```

## UPDATE statement
Basic syntax:
```sql
UPDATE table
SET new_value
WHERE criteria
```

Examples:
1. Increase the alcohol percentage of all beers with `soortnr` 21 by 0,5. Make this modification in the table `bieren_oud`.
    ```sql
    UPDATE bieren_oud
    SET alcohol = alcohol + 0.5
    WHERE soortnr = 21
    ```

2. Lower the alcohol percentage by 1 of all beers whose brewery has a revenue (`omzet`) larger than 25000. Make this modification in the table `bieren_oud`.
    ```sql
    UPDATE bieren_oud
    SET alcohol = alcohol - 1
    WHERE brouwerNr IN (SELECT brouwerNr FROM brouwers WHERE omzet > 25000)
    ```

## DELETE statement
Basic syntax:
```sql
DELETE [table]
FROM table-expression
WHERE criteria
```

**NOTE:**
* A DELETE statement always **removes an entire record**. It cannot remove specific fields; this should be done with an UPDATE instruction.
* To remove an entire table, you should use a DROP statement, not DELETE.
* Once removed with a DELETE statement, the records cannot be recovered. Before using a DELETE, use a SELECT instruction to select the correct records.

Examples:
1. Remove the beer with `biernr` 750 from the table `bieren_oud`.
    ```sql
    DELETE
    FROM bieren_oud
    WHERE biernr=750
    ```

2. Remove the beers that were brewn in Soy from the table `bieren_oud`.
    ```sql
    DELETE
    FROM bieren_oud
    WHERE brouwerNr IN (SELECT brouwerNr FROM brouwers WHERE gemeente = 'soy')
    ```

## CREATE TABLE
### A. Empty table
Basic syntax:
```sql
CREATE TABLE table
(field1 type [(size)] [NOT NULL] [index1]
[, field2 type [(size)] [NOT NULL] [index2] [,...]
[CONSTRAINT multipleindex [,...]])
```
If `NOT NULL` is used, the field should always have a value.

**Example:**  
Make a new table 'klanten' with the fields 'klantnr', 'klnaam', 'kladres', 'klpost' and 'klgemeente'. The fields 'klantnr' and 'klnaam' should always have a value.
```sql
CREATE TABLE klanten
(klantnr integer NOT NULL, klnaam varchar(30) NOT NULL,
kladres varchar(40), klpost char(4), klgemeente varchar(40))
```

### B. With data from another table
Basic syntax:
```sql
CREATE TABLE newtable
AS SELECT field1[,field2[,...]]
FROM source
```
The fields will be copied to the new table from the source table.

**Example:**  
Create a table 'alcoholarm', and put in the data from the low-alcohol beers. Also put in the name of the brewery and the name of the beer.
```sql
CREATE TABLE alcoholarm
AS SELECT naam, brNaam
FROM bieren
INNER JOIN brouwers ON bieren.brouwernr=brouwers.brouwernr
INNER JOIN soorten ON bieren.soortnr=soorten.soortnr
WHERE soort='Alcoholarm'
```

## DROP TABLE
`DROP TABLE` removes an existing table entirely from the database.

Basic syntax:
```sql
DROP TABLE [table]
```

**Example:**  
Remove the table 'klanten'.
```sql
DROP TABLE klanten
```

## ALTER TABLE
### A. Add a field
Basic syntax:
```sql
ALTER TABLE table
ADD [COLUMN] field type [(size)] [NOT NULL],
field2 type [(size)] [NOT NULL],...,
fieldn type [(size)] [NOT NULL]
```
`size` is only for text and binary fields, and indicates the size in characters. `size` should always be enclosed in parenthesis `()`. `NOT NULL` indicates only correct data can be entered when adding new records.

**Example:**  
Add a field 'opmerkingen' to the table 'brouwers'.
```sql
ALTER TABLE brouwers
ADD opmerkingen varchar(25)
```

### B. Remove a field
Basic syntax:
```sql
ALTER TABLE table
DROP [COLUMN] field1, DROP [COLUMN] field2, ... fieldn
```

**Example:**  
Remove the field 'opmerkingen' and 'contactpersoon' from the table 'brouwers'.
```sql
ALTER TABLE brouwers
DROP opmerkingen, DROP contactpersoon
```

## CONSTRAINT
`CONSTRAINT` is only used in a `CREATE TABLE` or `ALTER TABLE` statement to define keys or relationships. It allows us to define constraints on 1 or more fields:
- **UNIQUE**: assign a **unique index** to a field; this prevents 2 records from having the same value for this field. When applied to multiple fields, the *combination of the values* in the fields needs to be unique.
- **Primary key**: Only 1 per table, and should be **UNIQUE** and NOT NULL.
- **Foreign key**: A field (or combination of fields) that refers to the primary key of another table.

**Examples:**  
* Create a table 'klanten' with the fields 'klantId' and 'klantNaam'. 'klantId' is the primary key. 'klantNaam' should always have a value, that can at maximum be 30 characters.
  ```sql
  CREATE TABLE klanten
  (klantId integer NOT NULL auto_increment, klantNaam varchar(30) NOT NULL,
  CONSTRAINT pk_klantId PRIMARY KEY(klantId))
  ```
  'pk_klantId' is the name of the constraint; pk for primary key. `auto_increment` indicates the field will be numbered automatically, and can only be used on primary keys.
  
* Create a table 'gebruikers' with the fields 'nummer', 'naam' and 'userId'. The field 'userId' needs to have a unique value, but isn't the primary key. 'nummer' is the primary key.
  ```sql
  CREATE TABLE gebruikers
  (nummer integer NOT NULL,
  naam varchar(30),
  userId varchar(8),
  CONSTRAINT pk_nummer PRIMARY KEY(nummer),
  CONSTRAINT u_userId UNIQUE(userId))
  ```

* Create a table 'bestellingen' with the fields 'bestelId', 'klantNummer' and 'besteldatum'. The primary key is 'bestelId'. Between the fields 'klantNummer' of this table and 'klantId' of the table 'klanten' we define a one-to-many relationship.
  ```sql
  CREATE TABLE bestellingen
  (bestelId integer,
  klantNummer integer,
  besteldatum datetime,
  CONSTRAINT pk_bestelId PRIMARY KEY (bestelId),
  CONSTRAINT f_klantnummer FOREIGN KEY (klantnummer) REFERENCES klanten (klantId))
  ```

* Create a table 'bestellijnen' with the fields 'bestelNummer', 'bierNummer' and 'aantal'. Define a composite key with the fields 'bestelNummer' and 'bierNummer'.
  ```sql
  CREATE TABLE bestellijnen
  (bestelNummer integer,
  bierNummer integer,
  aantal integer,
  CONSTRAINT pk_bestelBier PRIMARY KEY (bestelNummer, bierNummer))
  ```

* Define a one-to-many relationship between the tables 'bestellingen' (bestelId) and 'bestellijnen' (bestelnummer).
  ```sql
  ALTER TABLE bestellijnen
  ADD CONSTRAINT f_bestelnummer FOREIGN KEY (bestelnummer) REFERENCES bestellingen (bestelId)
  ```

* Remove the constraint 'f_bestelnummer'.
  ```sql
  ALTER TABLE bestellijnen
  DROP FOREIGN KEY f_bestelnummer
  ```

* Remove the primary key of the table 'bestellijnen'.
  ```sql
  ALTER TABLE bestellijnen
  DROP PRIMARY KEY
  ```

## Indexes
### Why indexes?
Some SQL instructions like `CREATE TABLE` have a near constant processing time, that cannot be changed. Other instructions like `SELECT`, `UPDATE` and `DELETE` can be sped up significantly with indexes. Most database systems automatically add an index to the fields of a primary key.

To get data from a table without an index the database system performs a **tablescan**, i.e. a complete search of the entire table. When an index is defined, the database can consult it first and possibly find the data directly, which is much faster.

### Define an index
```sql
CREATE [UNIQUE] INDEX name
ON table (field [asc | desc] [, field [asc | desc] [,...]])
```

**Example:**  
Create an index for the field 'klantnaam' of the table 'klanten'.
```sql
CREATE INDEX i_naam
ON klanten (klantNaam)
```

### Remove an index
```sql
DROP INDEX name ON table
```

**Example:**  
Remove the index 'i_naam' of the table 'klanten'.
```sql
DROP INDEX i_naam
ON klanten
```

## Views
A view can be seen as a virtual table that is summoned by a `SELECT` statement.
A much used application of views is for shielding data to implement security/privacy.

### A. Create a view
```sql
CREATE VIEW viewname
AS "SELECT-instruction"
```
`ORDER BY` is not allowed. All other instructions are allowed, including aggregate functions and math operations.

**Example:**  
Create a view 'bierlijst'. This list contains the name of the beer, the name of the brewery and the kind of the beer.
```sql
CREATE VIEW bierlijst
AS SELECT naam, brNaam, soort
FROM bieren INNER JOIN brouwers
ON bieren.brouwernr = brouwers.brouwernr
INNER JOIN soorten
ON bieren.soortnr = soorten.soortnr
```
You can now look at this list with: `SELECT * FROM bierlijst`. It should be visible in the schema too.

### B. Delete a view
```sql
DROP VIEW viewname
```

**Example:**  
```sql
DROP VIEW bierlijst
```

