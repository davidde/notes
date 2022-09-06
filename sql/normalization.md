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
**Example:** Normalize the below order form
```
╔═════════════════════════════════╦════════════════════════════════╗
║ Order ID: 8254                  ║ Date: 12/09/2003               ║
╠═════════════════════════════════╩════════════════════════════════╣
║ Client 612                                                       ║
║ Tom Jones                                                        ║
║ Sesame Street 2                                                  ║
║ 3001 Dreamland                                                   ║
╠════════════════╦══════════════╦══════════╦══════════╦════════════╣
║ Article Number ║ Description  ║ Quantity ║ Price    ║ Amount     ║
╠════════════════╬══════════════╬══════════╬══════════╬════════════╣
║ zxfST478       ║ Armchair ZXF ║ 4        ║ 110.00   ║ 440.00     ║
║ zxfBU479       ║ Desk ZXF     ║ 2        ║ 315.50   ║ 631.00     ║
║                ║              ║          ║          ║            ║
║                ║              ║          ║          ║            ║
╠════════════════╩══════════════╩══════════╩══════════╬════════════╣
║                                              TOTAL: ║ 1071.00    ║
║                                                     ╚════════════╣
║ Delivery Date: 05/10/2003                                        ║
╚══════════════════════════════════════════════════════════════════╝
```

### 0. Preparation
1. Make a **list of all data** or attributes that are relevant.
2. Remove all attributes that are the result of a **calculation** based on other attributes.
3. Remove all attributes with a **constant value**, like the name and address of the company for which we're doing the analysis. These attributes are called the process attributes.
4. Check if there are **homonyms or synonyms** among the attributes and modify them if necessary.
   - homonym: the same word that references 2 different concepts.
     E.g. "Name" that references a client name, and later on a product name.
   - synonym: 2 different words that mean the same.
     E.g. One document mentions an articleCode, another an articleNumber, but it's really the same thing.
5. Choose one attribute as **KEY** of which the other attributes depend (primary key): underline this attribute as indicator.
6. Identify **repeating groups** with `RG [repeating attributes]`, i.e. collections of attributes that repeat compared to the key.

**Example:**  
<u>orderID</u>, orderDate, clientNumber, firstName, lastName, street, houseNumber, bus, postalCode, place, RG [articleNumber, description, quantity, price, ~~amount~~], ~~total~~, deliveryDate


### 1. First Normal Form
1. Put the repeating groups in different tables. The key of the original table needs to be repeated in the new tables, even though it is not part of a repeating group (foreign key, which we put in bold).
2. Find a (primary) key for the new tables.
3. Repeat this until there no longer are repeating groups.

**Example:**  
When "creating" the tables, we obviously have to name them too. Since our example deals with **orders** and its specific order lines, those are good names:
- Orders (<u>orderID</u>, orderDate, clientNumber, firstName, lastName, street, houseNumber, bus, postalCode, place, deliveryDate)
- OrderLines (<u>**orderID**, articleNumber</u>, description, quantity, price)

`orderID` by itself cannot uniquely identify an `OrderLine` record, so as a primary key it needs to be combined with articleNumber. We underline both to indicate they're the primary key.

### 2. Second Normal Form
1. Identify all tables with a composite key.
2. Find all attributes that do not depend on the entire composite key. If it is a homonym, replace it with more specific attributes.
3. Group the attributes that are functionally dependant of only a part of the key in a new table with their own key. The key also remains in the original table, where we put it in bold, to indicate it is a foreign key, that refers to the new table.
4. Repeat this for all tables with a composite key.

**Example:**  
The articles are not functionally dependent of the orderID, so we should move them to a different table, which we'll call, unsurprisingly, `Articles`. `price` is in fact a homonym where we need to distinguish between a **list price** (= catalogusprijs) and **sale price** (= verkoopprijs). A sale price is functionally dependent on an order (since the article can be in promotion when the order is placed), while the list price remains the same and is a "part" of the article definition:
- Orders (<u>orderID</u>, orderDate, clientNumber, firstName, lastName, street, houseNumber, bus, postalCode, place, deliveryDate)
- OrderLines (<u>**orderID, articleNumber**</u>, quantity, salePrice)
- Articles (<u>articleNumber</u>, description, listPrice)

### 3. Third Normal Form
1. The attributes that are not dependent on the key should be removed from the table. They are often functionally dependent on an attribute that is not a key.
   If this is not the case, we will have to create a **surrogate key**, e.g. a `clientId` if it was missing.
2. Create a new table from these attributes, together with the attribute on which they are dependant.

**Example:**  
The client data is not functionally dependent on the `orderID`, but only on the `clientNumber`, so we can put them in a different table. Also, `place` and `postalCode` are not dependent on the `clientNumber`, so we can put them in a different table too:
- Orders (<u>orderID</u>, orderDate, **clientNumber**, deliveryDate)
- Clients (<u>clientNumber</u>, firstName, lastName, street, houseNumber, bus, **placeID**)
- Places (<u>placeID</u>, postalCode, place)
- OrderLines (<u>**orderID, articleNumber**</u>, quantity, salePrice)
- Articles (<u>articleNumber</u>, description, listPrice)

### 4. Surrogate keys
A surrogate key is an identification number added by the database, and as such has no inherent meaning. This is in contrast to a **natural key** which consists of data with meaning.

Surrogate keys are also useful for maximizing performance. If a key is non-numeric, or consists of multiple fields, the database indexes are less efficient, which reduces performance. In that case a surrogate key is a good idea.

There are 3 steps to replace natural keys with surrogate keys, which we have to repeat for every key in our model:
1. Determine if the natural key qualifies for replacement with a surrogate key. If yes, call the new surrogate key `+ID`.
2. Define a unique index on the natural key that now no longer is a primary key, so it remains unique in the database.
3. Replace the foreign key with the new surrogate key.

**Example:**  
In our example, the `articleNumber` is non-numeric (`zxfST478`), which is inefficient for the database. We replace it with an `articleID` surrogate key, and put a unique index on `articleNumber`:
- Orders (<u>orderID</u>, orderDate, **clientNumber**, deliveryDate)
- Clients (<u>clientNumber</u>, firstName, lastName, street, houseNumber, bus, **placeID**)
- Places (<u>placeID</u>, postalCode, place)
- OrderLines (<u>**orderID, articleID**</u>, quantity, salePrice)
- Articles (<u>articleID</u>, articleNumber, description, listPrice)

**Unique indexes:**
| table    | field         |
|----------|---------------|
| Articles | articleNumber |