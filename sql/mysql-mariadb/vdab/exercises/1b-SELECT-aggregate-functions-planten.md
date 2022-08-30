# SELECT - Aggregate Functions
## Database planten
1. Hoeveel leveranciers telt ons tuincentrum?
    ```sql
    SELECT count(*) as aantal FROM leveranciers
    ```

2. Geef de gemiddelde prijs van alle waterplanten.
    ```sql
    SELECT avg(prijs) as gemiddelde
    FROM planten
    WHERE soort = 'water'
    ```

3. Geef de gemiddelde, de laagste en de hoogste offerteprijs van leverancier 4.
    ```sql
    SELECT avg(offertePrijs) as gemiddelde,
      min(offertePrijs) as laagste, max(offertePrijs) as hoogste
    FROM artikelsleveranciers
    WHERE leverancierId=4
    ```

4. Wat is de maximale hoogte van de bomen in de table 'planten'?
    ```sql
    SELECT max(hoogte) as maxhoogte
    FROM planten
    WHERE soort='boom'
    ```

5. Wat is de laagste offerteprijs voor artikel 1?
    ```sql
    SELECT min(offertePrijs) as minimum
    FROM artikelsleveranciers
    WHERE plantId=1
    ```

6. Geef bestelnummer, artikelLeverancierId en het totale bestelbedrag per bestelrij uit de table 'bestellijnen'.
    ```sql
    SELECT bestelId, artikelLeverancierId, (aantal*bestelPrijs) as totaal
    FROM bestellijnen
    ```

7. Maak een overzicht van de heesters uit de table 'planten', waarbij je de prijzen met 5% verhoogt.
    ```sql
    SELECT plantId, plantNaam, prijs * 1.05 as verhoogd
    FROM planten
    WHERE soort = 'heester'
    ```

8. Hoeveel stuks van leveranciersartikelnummer 59 zijn er besteld?
    ```sql
    SELECT sum(aantal) as aantal
    FROM bestellijnen
    WHERE artikelLeverancierId = 59
    ```

9. Wat is het totale bestelbedrag (exclusief korting) voor leveranciersartikelnummer 8?
    ```sql
    SELECT sum(aantal*bestelPrijs) as totaal
    FROM bestellijnen
    WHERE artikelLeverancierId = 8
    ```
