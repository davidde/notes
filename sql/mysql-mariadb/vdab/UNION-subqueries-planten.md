# Union and subqueries
## Database planten
1. Het tuincentrum wil graag een lijst waarop is aangegeven welke bomen in Aalsmeer en welke buiten Aalsmeer verkrijgbaar zijn. Op het overzicht moeten de volgende gegevens verschijnen: plantId, plantennaam, artikelcode van de leverancier, alsmede een aanduiding 'AALSMEER' of 'BUITEN AALSMEER'. Sorteer de lijst op plantId.
   ```sql
   SELECT planten.plantId, plantNaam, artikelLeverancierCode, 'Aalsmeer' as locatie
   FROM planten
   INNER JOIN artikelsLeveranciers ON planten.plantId = artikelsLeveranciers.plantId
   INNER JOIN leveranciers ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
   WHERE woonplaats='Aalsmeer' AND soort='boom'
   UNION
   SELECT planten.plantId, plantNaam, artikelLeverancierCode, 'Buiten Aalsmeer' as locatie
   FROM planten
   INNER JOIN artikelsLeveranciers ON planten.plantId = artikelsLeveranciers.plantId
   INNER JOIN leveranciers ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
   WHERE woonplaats<>'Aalsmeer' AND soort='boom'
   ORDER BY plantId
   ```

2. Je wil een overzicht waarop is aangegeven welke bestellijnen te laat zijn. Voor de bestellijnen die te laat zijn moet in een extra kolom de opmerking 'TE LAAT' worden geplaatst; voor de andere bestellijnen wordt in die kolom een aantal streepjes geplaatst.

   Sorteer het overzicht op 'bestelId'.

   Geef bestelId, artikelLeverancierId, besteldatum, leveringsdatum, levertijd, bericht 'TE LAAT' of '-------'.

   **Tip:** Om het verschil tussen twee data te berekenen, heb je de functie datediff(datum1,datum2) nodig.
   
   WRONG:
    ```sql
    SELECT bestelId, artikelLeverancierId, bestelDatum,
    leveringsDatum, levertijd, 'TE LAAT' as bericht
    FROM bestellingen
    INNER JOIN artikelsLeveranciers
    ON bestellingen.leverancierId = artikelsLeveranciers.leverancierId
    WHERE datediff(bestelDatum,leveringsDatum) > levertijd
    UNION
    SELECT bestelId, artikelLeverancierId, bestelDatum,
    leveringsDatum, levertijd, '--------' as bericht
    FROM bestellingen
    INNER JOIN artikelsLeveranciers
    ON bestellingen.leverancierId = artikelsLeveranciers.leverancierId
    WHERE datediff(bestelDatum,leveringsDatum) <= levertijd
    ORDER BY bestelId
    ```

    CORRECT:
    ```sql
    SELECT bestellingen.bestelId, bestellijnen.artikelLeverancierId,
    bestelDatum, leveringsDatum, levertijd, 'TE LAAT' as bericht
    FROM bestellingen
    INNER JOIN bestellijnen ON bestellingen.bestelId=bestellijnen.bestelId
    INNER JOIN artikelsleveranciers
    ON artikelsleveranciers.artikelLeverancierId=bestellijnen.artikelLeverancierId
    WHERE datediff(leveringsDatum,bestelDatum) > levertijd
    UNION
    SELECT bestellingen.bestelId, bestellijnen.artikelLeverancierId,
    bestelDatum, leveringsDatum, levertijd, '-------' as bericht
    FROM bestellingen
    INNER JOIN bestellijnen ON bestellingen.bestelId=bestellijnen.bestelId
    INNER JOIN artikelsleveranciers
    ON artikelsleveranciers.artikelLeverancierId=bestellijnen.artikelLeverancierId
    WHERE datediff(leveringsDatum,bestelDatum) <= levertijd
    ORDER BY bestelId
    ```

3. Welke planten zijn hoger dan de gemiddelde hoogte van alle planten samen? Toon alle gegevens.
    ```sql
    SELECT * FROM planten
    WHERE hoogte > (SELECT avg(hoogte) FROM planten)
    ```
  
4. Welke planten zijn duurder dan de gemiddelde prijs van de bomen? Toon alle gegevens.
    ```sql
    SELECT * FROM planten
    WHERE prijs > (SELECT avg(prijs)
    FROM planten
    WHERE soort='boom')
    ```

5. Maak een overzicht van de leveranciers (alle gegevens) waar nog bestellingen uitstaan met een leveringsDatum die vóór 1 april 2016 ligt.

    WRONG:
    ```sql
    SELECT * FROM leveranciers
    INNER JOIN bestellingen
    ON leveranciers.leverancierId = bestellingen.leverancierId
    WHERE leveringsDatum < '2016-4-1'
    ```

    CORRECT:
    ```sql
    SELECT * FROM leveranciers
    WHERE leverancierId in (SELECT leverancierId FROM bestellingen
    WHERE leveringsDatum < '2016-4-1')
    ```

6. Welke rijen hebben de laagste offerteprijs van alle offertes in de table artikelsleveranciers? Geef alle gegevens.
    ```sql
    SELECT * FROM artikelsLeveranciers
    WHERE offertePrijs = (SELECT min(offertePrijs) FROM artikelsleveranciers)
    ```

7. Welke planten zijn lager dan de laagste vaste plant?
  Toon alle gegevens.
  Planten waar de hoogte 0 is, worden niet meegerekend.

    WRONG:
    ```sql
    SELECT * FROM planten
    WHERE hoogte < (SELECT min(hoogte) FROM planten
    WHERE soort='vast')
    ```
    
    CORRECT:
    ```sql
    SELECT * FROM planten
    WHERE hoogte > 0 AND hoogte < (SELECT min(hoogte) FROM planten
    WHERE soort='vast' AND hoogte > 0)
    ```

8. Welke planten zijn hoger dan de gemiddelde hoogte van vaste planten en tevens goedkoper dan de gemiddelde prijs van vaste planten? Geef alle gegevens.
    ```sql
    SELECT * FROM planten
    WHERE hoogte > (SELECT avg(hoogte) FROM planten WHERE soort='vast')
    AND prijs < (SELECT avg(prijs) FROM planten WHERE soort='vast')
    ```

9. Welke planten hebben een prijs die tussen de laagste en hoogste prijs van de klimplanten ligt? Geef alle gegevens.
    ```sql
    SELECT * FROM planten
    WHERE prijs > (SELECT min(prijs) FROM planten WHERE soort='klim')
    AND prijs < (SELECT max(prijs) FROM planten WHERE soort='klim')
    ```

10. Maak een overzicht van de plantIds die een lagere offerteprijs hebben dan de gemiddelde offerteprijs voor de betreffende plantId.
Plaats de gegevens plantId, leveranciersnaam en offerteprijs op het overzicht. Sorteer op 'plantId'.
    ```sql
    SELECT plantId, leveranciernaam, offerteprijs
    FROM artikelsleveranciers AS al1
    INNER JOIN leveranciers
    ON al1.leverancierId = leveranciers.leverancierId
    WHERE offerteprijs < (SELECT avg(offerteprijs) FROM artikelsleveranciers AS al2
    WHERE al1.plantId=al2.plantId)
    ORDER BY plantId
    ```

11. Maak een overzicht van bestelde planten die een bestelprijs hebben welke hoger is dan de maximum offerteprijs voor zo’n plant.
  Plaats de volgende gegevens op het overzicht : bestelnummer, artikelcode van de leverancier, plantennaam en bestelprijs.
    ```sql
    SELECT bestellijnen.bestelid, al1.artikelLeverancierCode, plantNaam, bestelPrijs
    FROM artikelsleveranciers AS al1
    INNER JOIN bestellijnen
    ON al1.artikelLeverancierId = bestellijnen.artikelLeverancierId
    INNER JOIN planten
    ON al1.plantId = planten.plantId
    WHERE bestelprijs > (SELECT max(offerteprijs) FROM artikelsleveranciers AS al2
    WHERE al1.plantId=al2.plantId)
    ```
