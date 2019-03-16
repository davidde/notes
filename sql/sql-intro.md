# Intro to Relational Databases
(Notes on the Udacity Course)

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
create table animals (
    name text,
    species text,
    birthdate date,
);

create table diet (
    species text,
    food text,
);

create table taxonomy (
    name text,
    species text,
    genus text,
    family text,
    t_order text,
);

create table ordernames (
    t_order text,
    name text,
);
```
Remember: In SQL, we always put string **and date values** inside single quotes.

## Select statement and select clauses

The select statement can express arbitrary complex searches and aggregations
of data; it uses 'select clauses' like where, limit and order/group by for more
specific searches.
E.g. QUERY = "select * from animals where species = 'orangutan' order by birthdate;"   
The result of a query is always a (subset) table.

### where ...
The where clause expresses restrictions — filtering a table for rows that
follow a particular rule. where supports equalities, inequalities, and
boolean operators, e.g.:
* where species = 'gorilla'   
Return only rows that have 'gorilla' as the value of the species column.
* where name >= 'George'   
Return only rows where the name column is alphabetically after 'George'.
* where species != 'gorilla' and name != 'George'   
Return only rows where species isn't 'gorilla' and name isn't 'George'.

### limit ... (offset ...)
The limit clause sets a limit on how many rows to return in the result table.
The optional offset clause says how far to skip ahead into the results.
E.g. 'limit 10 offset 100'   
Return 10 results starting with the 101st.

### order by ... (desc)
The order by clause tells the database how to sort the results —
usually according to one or more columns. Ordering happens before limit/offset,
so you can use them together to extract pages of alphabetized results.
E.g. 'order by species, name'   
Sort results first by the species column, then by name within each species.

The optional desc modifier tells the database to order results in descending order —
for instance from large numbers to small ones, or from Z to A.

### group by ...
The group by clause is only used with aggregations, such as max, count or sum.
Without a group by clause, a select statement with an aggregation will
aggregate over the whole selected table(s), returning only one row.
With a group by clause, it will return one row for each distinct value
of the column or expression in the group by clause.

E.g. QUERY = "select species, min(birthdate) from animals group by species;" —
will return a table with 2 columns: the first with all the species, and the second
with the birthdate of the oldest animal of that species.
-> contrast this with:
QUERY = "select species, min(birthdate) from animals;"   
Will return only a single row of 2 columns: the species and the birthdate of
the oldest animal.


## Insert statement

The basic syntax for the insert statement:

insert into table ( column1, column2, ... ) values ( val1, val2, ... );

If the values are in the same order as the table's columns (starting with the
first column), you don't have to specify the columns in the insert statement:

insert into table values ( val1, val2, ... );

For instance, if a table has three columns (a, b, c) and you want to insert into
a and b, you can leave off the column names from the insert statement.
But if you want to insert into b and c, or a and c, you have to specify the columns.

A single insert statement can only insert into a single table. (Contrast this
with the select statement, which can pull data from several tables using a join.)


## Join statement

To join two tables, first choose the **join condition**, or the rule you want
the database to use to match rows from one table up with rows of the other table.
Then write a join in terms of the columns in each table.

E.g. Find the **names** of all individual animals that eat fish  
(animals columns: name, species, birthdate  
diet columns: species, food)  
-> Problem: the animals table tells us nothing about what each animal eats,
and the diet table doesn't list individual animals, ... only species.  
-> Solution: the species column is in both the animals and diet tables,
so we can do a 'join' between both tables:  
QUERY = '''  
select animals.name  
from animals join diet  
on animals.species = diet.species  
where food = 'fish';
'''  
join condition: on animals.species = diet.species  

Alternatively, we can use simple join syntax:  
select name from animals, diet  
where animals.species = diet.species  
and diet.food = 'fish';  


## Having clause

The having clause works like the where clause, but it applies after group by
aggregations take place. The syntax is like this:

select columns from tables group by column having condition ;

Usually, at least one of the columns will be an aggregate function such as
count, max, or sum on one of the tables' columns. In order to apply having to
an aggregated column, you'll want to give it a name using as. For instance,
if you had a table of items sold in a store, and you wanted to find all the
items that have sold more than five units, you could use:

```sql
select name, count(*) as num from sales having num > 5;
```

You can have a select statement that uses only where, or only group by,
or group by and having, or where and group by, or all three of them!

But it doesn't usually make sense to use having without group by.

If you use both where and having, the where condition will filter the rows
that are going into the aggregation, and the having condition will filter
the rows that come out of it.

HAVING is different from WHERE: WHERE filters individual rows before the
application of GROUP BY, while HAVING filters group rows created by GROUP BY. 

You can read more about having here:

http://www.postgresql.org/docs/9.4/static/sql-select.html#SQL-HAVING

Question: Which species does the zoo have only one of?
WRONG:
```sql
select species, count(*) as num
    from animals group by species
    where num = 1;
```
This is wrong because the value of num comes from count and group by,
but where always runs BEFORE aggregations!
We can correct this by changing a single word:
```sql
select species, count(*) as num
    from animals group by species
    having num = 1;
```

Question: Which food is eaten by only one individual animal?

There are a few different ways to solve this, but here's one of them:

```sql
select food, count(animals.name) as num
    from diet join animals
    on diet.species = animals.species
    group by food
    having num = 1;
```

And here is another:

```sql
select food, count(animals.name) as num
    from diet, animals
    where diet.species = animals.species
    group by food
    having num = 1;
```

## Normalised Database Design

In a normalised database, the relationships among the tables match
the relationships that are really there among the data.

Rules for normalised design:

1. Every row has the same number of columns.  
In practice, the database system won't let us literally have different
numbers of columns in different rows. But if we have columns that are
sometimes empty (null) and sometimes not, or if we stuff multiple values
into a single field, we're bending this rule.   
The example to keep in mind here is the diet table from the zoo database.
Instead of trying to stuff multiple foods for a species into a single row
about that species, we separate them out. This makes it much easier to do
aggregations and comparisons.

2. There is a unique **key**, and everything in a row says something about the key.  
The key may be one column or more than one. It may even be the whole row,
as in the diet table. But we don't have duplicate rows in a table.   
More importantly, if we are storing non-unique facts — such as people's
names — we distinguish them using a unique identifier such as a serial number.
This makes sure that we don't combine two people's grades or parking tickets
just because they have the same name.

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
e.g. (incorrect) job_skills table:

    |    Name       |   Technology   |    Language     |
    |---------------|----------------|-----------------|
    | Annabel       | Databases      | English         |
    | Annabel       | Linux          | French          |
    | Leon          | Data Science   | English         |
    | Leon          | Windows        | Kurdish         |

    => There is no relationship between Technology and Language,
    so they should be in different tables, one for tech_skills,
    and one for language_skills.

