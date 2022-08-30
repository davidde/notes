# Views
## Database planten
1. Definieer een view 'vastlaag' waarin alle gegevens van alle vaste planten uit de table 'planten' voorkomen met een hoogte van maximaal 15 cm.
    ```sql
    CREATE VIEW vastlaag
    AS
    SELECT * FROM planten
    WHERE soort = 'vast' AND hoogte <= 15
    ```

2. Definieer een view 'offerteprijzen' met de kolommen 'plantId', 'minOff', 'maxOff' en 'gemOff' waarin respectievelijk 'plantid', 'laagste', 'hoogste' en 'gemiddelde offerteprijs' vermeld zijn. 
    ```sql
    CREATE VIEW offerteprijzen
    AS
    SELECT plantId, min(offertePrijs) as minOff, max(offertePrijs) as maxOff,
    avg(offertePrijs) as gemOff
    FROM artikelsLeveranciers
    GROUP BY plantId
    ```

3. Maak een view 'zomerplanten' waarmee de gegevens 'plantid', 'plantennaam', 'soort' en 'prijs' zijn te benaderen van alle planten die in de maanden juni, juli of augustus beginnen te bloeien.
    ```sql
    CREATE VIEW zomerplanten
    AS
    SELECT plantid, plantNaam, soort, prijs
    FROM planten
    WHERE beginBloeiMaand IN (6, 7, 8)
    ```

4. Definieer een view 'bomen' met de gegevens 'plantId', 'plantennaam', 'hoogte' en 'prijs' van alle bomen.
    ```sql
    CREATE VIEW bomen
    AS
    SELECT plantid, plantNaam, hoogte, prijs
    FROM planten
    WHERE soort = 'boom'
    ```

5. Definieer een view 'leverancier5' waarin alleen van leverancier 5 de volgende gegevens staan: plantId, plantNaam, artikelLeverancierCode, offertePrijs, prijs.
    ```sql
    CREATE VIEW leverancier5
    AS
    SELECT planten.plantId, plantNaam, artikelLeverancierCode, offertePrijs, prijs
    FROM planten INNER JOIN artikelsLeveranciers
    ON planten.plantId = artikelsLeveranciers.plantId
    WHERE leverancierId = 5
    ```

6. Maak een view waardoor alleen de offertegegevens van de leveranciers uit Lisse zijn te selecteren.
    ```sql
    CREATE VIEW offertegegevens_Lisse
    AS
    SELECT artikelsleveranciers.* FROM artikelsLeveranciers
    INNER JOIN leveranciers
    ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
    WHERE woonplaats like 'Lisse'
    ```

7. Maak een view 'besteldeplanten' die een overzicht geeft van bestelid, artikelcode van de leverancier en de plantnaam.
    WRONG:
    ```sql
    CREATE VIEW besteldeplanten
    AS
    SELECT bestelId, artikelLeverancierCode, plantNaam
    FROM bestellingen
    INNER JOIN artikelsLeveranciers
    ON bestellingen.leverancierId = artikelsLeveranciers.leverancierId
    INNER JOIN planten
    ON artikelsLeveranciers.plantId = planten.plantId
    ```
    304 records.

    CORRECT:
    ```sql
    CREATE VIEW besteldeplanten
    AS
    SELECT bestelLijnen.bestelId, artikelLeverancierCode, plantNaam
    FROM planten
    INNER JOIN artikelsleveranciers
    ON planten.plantId = artikelsLeveranciers.plantId
    INNER JOIN bestelLijnen
    ON artikelsLeveranciers.artikelLeverancierId = bestellijnen.artikelLeverancierId
    ```
    97 records.