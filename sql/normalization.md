# Normalised Database Design
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


## Steps for normalised database design
### 0. Preparation
1. Make a **list of all data** or attributes that are relevant.
2. Remove all attributes that are the result of a **calculation** based on other attributes.
3. Remove all attributes with a **constant value**, like the name and address of the company for which we're doing the analysis. These attributes are called the process attributes.
4. Check if there are **homonyms or synonyms** among the attributes and modify them if necessary.
   - homonym: the same word that references 2 different concepts.
     E.g. "Name" that references a client name, and later on a product name.
   - synonym: 2 different words that mean the same.
     E.g. One document mentions an articleCode, another an articleNumber, but it's really the same thing.
5. Choose one attribute as **KEY** of which the other attributes depend (primary key).
6. Identify **repeating groups**, collections of attributes that repeat compared to the key.

### 1. First Normal Form
1. Put the repeating groups in different tables. The key of the original table needs to be repeated in the new tables, even though it is not part of a repeating group (foreign key).
2. Find a new (primary) key for the new tables.

### 2. Second Normal Form
1. Identify all tables with a composite key.
2. Find all attributes that only do not depend on the entire composite key. If it is a homonym, create the required new attributes.
3. Group the attributes that are functionally dependant of only a part of the key in a new table with their own key.

(Do this for all tables with a composite key.)

### 3. Third Normal Form
1. The attributes that are not dependent of the key should be removed from the table. They are often functionally dependent of an attribute that is not a key.
   If this is not the case, we will have to create a key; a surrogate key.
2. Create a new table from these attributes, together with the attribute of which they are dependant.





