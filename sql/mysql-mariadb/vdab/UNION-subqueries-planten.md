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

3. 