# INSERT - ALTER
## Database video
1. Voeg jezelf toe als klant.

    (zoek eerst volgend klantId op: 31)
    ```sql
    INSERT INTO klanten
    VALUES (31, 'Deprost', 'David', 'Kammerstraat 16', '9000', 'Gent', 1, 0, '2022-08-30', 0)
    ```

2. Geef alle films met maatschappijCode 'VH' een prijsverhoging van 10%.
    ```sql
    UPDATE films
    SET prijs = prijs * 1.1
    WHERE maatschappijId = (SELECT maatschappijId FROM maatschappijen WHERE maatschappijCode='VH')
    ```

3. Maak een table met enkel de films van het genre 'Thriller'.
    ```sql
    CREATE TABLE thrillers
    AS SELECT *
    FROM (SELECT filmId, titel, genre FROM films
    INNER JOIN genres ON films.genreId = genres.genreId
    WHERE genre = 'thriller') as t
    ```

4. Voeg aan de table 'maatschappijen' een veld 'mailadres' toe. Dit veld mag maximaal 40 tekens lang zijn en mag niet leeg zijn.
    ```sql
    ALTER TABLE maatschappijen
    ADD mailadres varchar(40) NOT NULL
    ```

5. Definieer alle nodige keys.
    ```sql
    ALTER TABLE films
    ADD CONSTRAINT f_genreId foreign key (genreId) references genres (genreId);

    ALTER TABLE films
    ADD CONSTRAINT f_maatschappijId foreign key (maatschappijId) references maatschappijen (maatschappijId);

    ALTER TABLE verhuringen
    ADD CONSTRAINT f_filmId foreign key (filmId) references films (filmId);

    ALTER TABLE verhuringen
    ADD CONSTRAINT f_klantId foreign key (klantId) references klanten (klantId);
    ```
