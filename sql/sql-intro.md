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

## Normalised Database Design
In a normalised database, the relationships among the tables match the relationships that are really there among the data.

**Rules for normalised design:**

1. Every row has the same number of columns.  
In practice, the database system won't let us literally have different numbers of columns in different rows. But if we have columns that are sometimes empty (null) and sometimes not, or if we stuff multiple values into a single field, we're bending this rule.

   The example to keep in mind here is the diet table from the zoo database. Instead of trying to stuff multiple foods for a species into a single row about that species, we separate them out. This makes it much easier to do aggregations and comparisons.

2. There is a unique **key**, and everything in a row says something about the key.  
   The key may be one column or more than one. It may even be the whole row, as in the diet table. But we don't have duplicate rows in a table.

   More importantly, if we are storing non-unique facts — such as people's names — we distinguish them using a unique identifier such as a serial number. This makes sure that we don't combine two people's grades or parking tickets just because they have the same name.

3. Facts that don't relate to the key belong in different tables.

   * Incorrect:

     |    Item       |   Count   |    location     |     address     |
     |---------------|-----------|-----------------|------------------
     | Rubber duck   |    43     | Ducky Park      | 123 Quaker Rd.  |
     | Tennis ball   |    117    | Ducky Park      | 123 Quaker Rd.  |
     | Mutant cat    |    27     | Secret Lab      | 1 Rainbow Falls |

   * Correct:  
     A separate item and locations table:

     - Items:
  
       |    Item       |   Count   |    location     |
       |---------------|-----------|-----------------|
       | Rubber duck   |    43     | Ducky Park      |
       | Tennis ball   |    117    | Ducky Park      |
       | Mutant cat    |    27     | Secret Lab      |

     - Locations:

       |    location     |     address     |
       |-----------------|-----------------|
       | Ducky Park      | 123 Quaker Rd.  |
       | Secret Lab      | 1 Rainbow Falls |

       The address isn't a fact about the item; it's a fact about the location.
       Moving it to a separate table saves space and reduces ambiguity,
       and we can always reconstitute the original table using a join.

4. Tables shouldn't imply relationships that don't exist.

   E.g. (incorrect) "job_skills" table:

    |    Name       |   Technology   |    Language     |
    |---------------|----------------|-----------------|
    | Annabel       | Databases      | English         |
    | Annabel       | Linux          | French          |
    | Leon          | Data Science   | English         |
    | Leon          | Windows        | Kurdish         |

    => There is no relationship between Technology and Language, so they should be in different tables, one for "tech_skills", and one for "language_skills".

