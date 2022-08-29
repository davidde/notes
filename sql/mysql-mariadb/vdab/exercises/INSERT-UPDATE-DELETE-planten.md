# INSERT-UPDATE-DELETE
## Database planten
1. Het tuincentrum breidt zijn leverancierskring uit met 'GROEN BV'. De volgende gegevens zijn bekend: 
   - Naam: Groen BV.
   - Adres: Onder de Linde 234
   - Woonplaats: Aalsmeer

    ```sql
    INSERT INTO leveranciers (leverancierNaam, adres, woonplaats)
    VALUES ('Groen BV.', 'Onder de Linde 234', 'Aalsmeer')
    ```

2. Wijzig in de table 'bestellingen' de leverdatum in 5 april 2016 voor de bestelling met nummer 8. 
    ```sql
    UPDATE bestellingen
    SET leveringsDatum = '2016-4-5'
    WHERE bestelId = 8
    ```

3. Verwijder alle rijen uit de table 'artikelsleveranciers' die betrekking hebben op de heesters van leverancier 8.
    ```sql
    DELETE
    FROM artikelsleveranciers
    WHERE leverancierId=8 AND plantId in (SELECT plantId FROM planten WHERE soort='heester')
    ```

4. Op 23 april 2016 is een nieuwe bestelling geplaatst bij leverancier 4. Dit zijn de details: 

    | ArtikelLeverancierId | Aantal | Prijs |
    |----------------------|--------|-------|
    | 62                   | 10     | 8.15  |
    | 58                   | 200    | 0.40  |
    | 59                   | 25     | 2.30  |
    | 74                   | 50        | 1.30  |

    De leverancier geeft 8% korting op het bruto bestelbedrag. De leverdatum is één week na de bestelling.

    Doe de nodige aanpassingen in de tables 'bestellingen' en 'bestellijnen'. Denk aan de volgorde!

    Oplossing:
    - Toevoegingen aan de table 'bestellingen': 
        ```sql
        INSERT INTO bestellingen (leverancierId, bestelDatum, leveringsDatum, korting)
        VALUES (4, '2016-4-23', '2016-4-30', 0.08)
        ```
    - Zoek het bestelnr van de laatst toegevoegde bestelling.
        ```sql
        SELECT *
        FROM bestellingen
        ```
        Het laatste record heeft als bestelId 16.
    - Toevoegingen aan de table 'bestellijnen': 
        ```sql
        INSERT INTO bestellijnen (bestelId, artikelLeverancierId, aantal, bestelprijs)
        VALUES (16, 62, 10, 8.15),
        (16, 58, 200, 0.4),
        (16, 59, 25, 2.3),
        (16, 74, 50, 1.3)    
        ```

5. Verhoog alle offerteprijzen van de bolgewassen in de table 'artikelsleveranciers' met 10%.
    ```sql
    UPDATE artikelsleveranciers
    SET offertePrijs = offertePrijs * 1.1
    WHERE plantId in (SELECT plantId FROM planten WHERE soort='bol')
    ```

6. Voeg de informatie van de planten met een hoogte groter of gelijk aan 1000 toe aan de table 'planten_oud'. Zorg dat de hoogste planten bovenaan staan. 
    ```sql
    INSERT INTO planten_oud
    SELECT * FROM planten
    WHERE hoogte >= 1000
    ORDER BY hoogte DESC
    ```
