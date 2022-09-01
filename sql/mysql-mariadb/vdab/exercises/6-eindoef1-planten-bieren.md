## Database PLANTEN
1. Geef een lijst van planten met in de naam het woord BLOEM en die tevens een gele of een blauwe kleur hebben.
    ```sql
    SELECT * FROM planten
    WHERE plantNaam LIKE '%bloem%' AND kleur IN ('geel', 'blauw')
    ```

2. Geef per leverancier een overzicht welke soorten ze aanbieden. Toon naam van de leverancier en de soort. Sorteer op naam, dan op soort.
    ```sql
    SELECT DISTINCT leverancierNaam, soort FROM leveranciers
    INNER JOIN artikelsLeveranciers
    ON leveranciers.leverancierId = artikelsLeveranciers.leverancierId
    INNER JOIN planten
    ON artikelsLeveranciers.plantId = planten.plantId
    ORDER BY leverancierNaam, soort
    ```

3. Toon twee plantnamen naast elkaar van planten die dezelfde prijs hebben.
   Sorteer op eerste naam dan op prijs.
    ```sql
    SELECT p1.plantNaam, p2.plantNaam, p2.prijs
    FROM planten AS p1
    INNER JOIN planten AS p2
    ON p1.prijs = p2.prijs AND p1.plantNaam < p2.plantNaam
    ORDER BY p1.plantNaam, prijs
    ```

4. Geef een overzicht van de waarde van de bestellingen per maand/jaar.
   Uw overzicht bevat 3 kolommen: jaar, maand, totaleBestelbedrag.
   Sorteer op jaar dan op maand.

   **Opmerking:**
   - year(datum) geeft het jaartal uit de datum
   - month(datum) geeft het maandnummer uit de datum

    ```sql
    SELECT year(bestelDatum) as jaar, month(bestelDatum) as maand,
    sum(aantal * bestelPrijs) as totaleBestelBedrag FROM bestellijnen
    INNER JOIN bestellingen
    ON bestellijnen.bestelId = bestellingen.bestelId
    GROUP BY maand, jaar
    ```

5. Verhoog de offerteprijs van alle heesters met 2%.
    ```sql
    UPDATE artikelsLeveranciers
    SET offertePrijs = offertePrijs * 1.02
    WHERE plantId in (SELECT plantId
    FROM planten WHERE soort = 'heester')
    ```

6. Verhoog de prijs uit de tabel planten met 1% van alle leveranciers uit Aalsmeer.
    ```sql
    UPDATE planten
    SET prijs = prijs * 1.01
    WHERE planten.plantId in (
    SELECT artikelsLeveranciers.plantId FROM artikelsLeveranciers
    INNER JOIN leveranciers
    ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
    WHERE woonplaats = 'aalsmeer')
    ```

7. ! Verwijder uit de tabel artikelsleveranciers alle gegevens van de waterplanten die geleverd worden door leverancier “ERICA BV.”
    ```sql
    DELETE
    FROM artikelsLeveranciers
    WHERE plantId IN (SELECT plantId FROM planten
    WHERE soort = 'water')
    AND leverancierId IN (SELECT leverancierId FROM leveranciers
    WHERE leverancierNaam = 'ERICA BV.')
    ```

8. Maak een nieuwe tabel ZONDER_KLEUR waarin alle gegevens van planten staan waarvan de kleur niet is ingevuld.
    ```sql
    CREATE TABLE ZONDER_KLEUR
    AS SELECT *
    FROM planten
    WHERE kleur IS NULL
    ```


## Database BIEREN
9. Geef de namen van de brouwerijen die maar één bier brouwen.
    ```sql
    SELECT brNaam, count(*) AS aantal FROM brouwers
    INNER JOIN bieren
    ON brouwers.brouwerNr = bieren.brouwerNr
    GROUP BY brNaam
    HAVING aantal = 1
    ```

10. Geef de namen van bieren waarin een tekst tussen ronde haakjes voorkomt.
    ```sql
    SELECT naam FROM bieren
    WHERE naam LIKE '%(%)%'
    ```

11. ! Geef per soort de soort, naam en alcohol van het strafste bier van die soort.

    WRONG:
    ```sql
    SELECT soort, naam, max(alcohol) as alcohol FROM bieren
    INNER JOIN soorten
    ON bieren.soortNr = soorten.soortNr
    GROUP BY soort
    ORDER BY soort
    ```

    CORRECT:
    ```sql
    SELECT Soort, Naam, Alcohol
    FROM bieren
    INNER JOIN soorten on bieren.SoortNr=soorten.SoortNr
    WHERE alcohol =
      (SELECT max(alcohol) FROM bieren
      WHERE bieren.soortnr=soorten.soortnr)
    ```

12. Tel het aantal bieren per soort. Geef van die soorten de soortnaam en het aantal. Sorteer de aantallen van groot naar klein.
    ```sql
    SELECT soort, count(*) as aantal FROM bieren
    INNER JOIN soorten
    ON bieren.soortNr = soorten.soortNr
    GROUP BY soort
    ORDER BY aantal DESC
    ```

13. Geef een lijst van bieren. Vermeld per bier de naam van het bier, het alcohol % en de tekst “BOVEN, ONDER of GELIJK”, naargelang het alcohol % van de bier boven, onder of gelijk aan het gemiddelde alcohol % van alle bieren valt. Sorteer op alcohol %.
    ```sql
    SELECT naam, alcohol, 'BOVEN' as label FROM bieren
    WHERE alcohol > (SELECT avg(alcohol) FROM bieren)
    UNION
    SELECT naam, alcohol, 'ONDER' as label FROM bieren
    WHERE alcohol < (SELECT avg(alcohol) FROM bieren)
    UNION
    SELECT naam, alcohol, 'GELIJK' as label FROM bieren
    WHERE alcohol = (SELECT avg(alcohol) FROM bieren)
    ORDER BY alcohol
    ```

14. ! Geef per soort het maximum alcohol % van de bieren van die soort en hoeveel bieren van die soort een alcohol % hebben gelijk aan dit maximum. Sorteer op soort.
    ```sql
    SELECT soort, max(alcohol) as max_alco, count(*) as aantal FROM bieren
    INNER JOIN soorten
    ON bieren.soortNr = soorten.soortNr
    WHERE alcohol in (SELECT max(alcohol) FROM bieren
    INNER JOIN soorten
    ON bieren.soortNr = soorten.soortNr
    GROUP BY soort)
    GROUP BY soort
    ORDER BY soort
    ```

15. Verwijder alle alcoholarme bieren met een alcoholpercentage groter dan 5%.
    ```sql
    DELETE
    FROM bieren
    WHERE alcohol > 5 AND soortNr = (SELECT soortNr from soorten
    WHERE soort = 'alcoholarm')
    ```
