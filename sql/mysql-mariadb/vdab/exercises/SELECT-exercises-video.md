# Gegevens selecteren
## Database Video
1. Geef een lijst van de klanten uit Gent of Wetteren met de velden naam, voornaam, postcode, woonplaats en klantstatus. Sorteer op klantstatus en naam.
    ```sql
    SELECT naam, voornaam, postcode, woonplaats, klantstatus
    FROM klanten 
    WHERE woonplaats IN ('gent', 'wetteren')
    ORDER BY klantstatus, naam
    ```

2. Maak een lijst van de klanten waarvan de postcode groter of gelijk is aan 9000 en de klanten waarvan het huuraantal groter is dan 200.  Deze lijst moet gesorteerd worden op postcode.
    ```sql
    SELECT *
    FROM klanten 
    WHERE postcode >= 9000 OR totaalGehuurd > 200
    ORDER BY postcode
    ```

3. Geef een lijst van de klanten wiens naam niet begint met een 'd'.
    ```sql
    SELECT *
    FROM klanten 
    WHERE naam NOT LIKE 'd%'
    ORDER BY naam
    ```

4. Geef een lijst van klanten waar in de naam van de gemeente op de derde plaats een 'n' staat.
    ```sql
    SELECT *
    FROM klanten 
    WHERE woonplaats LIKE '__n%'
    ORDER BY woonplaats
    ```

5. Bereken voor alle films de prijs incl BTW (21%).
    ```sql
    SELECT titel, prijs, prijs * 1.21 AS prijsInclBTW
    FROM films
    ```

6. Uit welke woonplaatsen komen onze klanten?
    ```sql
    SELECT DISTINCT woonplaats 
    FROM klanten 
    ORDER BY woonplaats
    ```

7. Maak een lijst van het aantal klanten per gemeente.
    ```sql
    SELECT woonplaats, count(*) AS aantalKlanten
    FROM klanten 
    GROUP BY woonplaats
    ORDER BY woonplaats
    ```

8. Maak een lijst die het mogelijk maakt een inzicht te krijgen in de verhuringen per gemeente. Op deze lijst moet de gemeente/stad met de meeste verhuringen bovenaan staan. Indien in een bepaalde gemeente geen 200 verhuringen gebeurd zijn, mag deze gemeente niet op de lijst staan.
    ```sql
    SELECT woonplaats, sum(totaalGehuurd) AS gehuurdPerWoonplaats
    FROM klanten 
    GROUP BY woonplaats HAVING gehuurdPerWoonplaats >= 200
    ORDER BY gehuurdPerWoonplaats DESC
    ```

