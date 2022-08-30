# Union and subqueries
## Database video
1. Geef een lijst van de films die in de titel noch het woord "kill" noch het woord "blood" hebben. We willen enkel de films van de genres griezel en thriller.
    ```sql
    SELECT * FROM films
    WHERE genreId in (SELECT DISTINCT genreId from genres
    WHERE genre='griezel' OR genre='thriller')
    AND titel NOT LIKE '%kill%' AND titel NOT LIKE '%blood%'
    ```

2. Maak een lijst van wie welke films huurt. Sorteer oplopend op naam en titel.
    ```sql
    SELECT verhuringen.klantId, naam, voornaam, titel FROM klanten
    INNER JOIN verhuringen
    ON klanten.klantId = verhuringen.klantId
    INNER JOIN films
    ON verhuringen.filmId = films.filmId
    ORDER BY naam, voornaam, titel
    ```

3. Wat is de totale voorraad per genre?

    WRONG:
    ```sql
    SELECT DISTINCT genre, count(*) AS aantal FROM films
    INNER JOIN genres ON films.genreId = genres.genreId
    GROUP BY films.genreId
    ```
    
    CORRECT:
    ```sql
    SELECT genre, sum(voorraad) AS totaleVoorraad
    FROM genres INNER JOIN films ON genres.genreId = films.genreId
    GROUP BY genre
    ```    
    
4. Geef alle gegevens van de duurste film.
    ```sql
    SELECT * FROM films
    WHERE prijs = (SELECT max(prijs) FROM films)
    ```
