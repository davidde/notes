## Database PLANTEN
1. Geef de plantennaam, soort, kleur, hoogte, de bloeimaand en de prijs van de planten die maximum in één maand bloeien.
    ```sql
    SELECT plantNaam, soort, kleur, hoogte, beginBloeiMaand AS bloeimaand, prijs
    FROM planten
    WHERE beginBloeimaand = eindBloeiMaand AND beginBloeiMaand <> 0
    ```

2. ! Geef de plantennaam en de soort van de planten die door meer dan drie leveranciers kunnen geleverd worden. Sorteer op soort, dan op plantennaam.
    ```sql
    SELECT plantNaam, soort FROM planten
    INNER JOIN artikelsLeveranciers
    ON planten.plantId = artikelsLeveranciers.plantId
    INNER JOIN leveranciers
    ON leveranciers.leverancierId = artikelsLeveranciers.leverancierId
    GROUP BY soort, plantNaam
    HAVING count(*) > 3
    ORDER BY soort, plantNaam
    ```

3. Toon per categorie het aantal planten en hun gemiddelde prijs. Sorteer op categorie.
    ```sql
    SELECT categorie, count(*) AS aantal, round(avg(prijs), 1) AS gemiddeldePrijs
    FROM categorieen INNER JOIN planten
    ON planten.categorieId = categorieen.categorieId
    GROUP BY categorie
    ORDER BY categorie
    ```

4. ! Zoek per plant de leverancier met de kortste leveringtermijn. Toon plantennaam, naam van de leverancier en de leveringstermijn.

    WRONG:
    ```sql
    SELECT plantNaam, leverancierNaam, min(levertijd) AS leveringstermijn
    FROM planten INNER JOIN artikelsLeveranciers
    ON planten.plantId = artikelsLeveranciers.plantId
    INNER JOIN leveranciers
    ON leveranciers.leverancierId = artikelsLeveranciers.leverancierId
    GROUP BY plantNaam
    ORDER BY plantNaam
    ```

    CORRECT:
    ```sql
    SELECT plantnaam, leverancierNaam, levertijd
    FROM artikelsleveranciers
    INNER JOIN planten ON artikelsleveranciers.plantId=planten.plantId
    INNER JOIN leveranciers
    ON artikelsleveranciers.leverancierId=leveranciers.leverancierId
    WHERE levertijd =
    (SELECT min(levertijd) FROM artikelsleveranciers
    WHERE plantid=planten.plantId)
    ```

5. Geef een overzicht van het aantal bestelde planten per maand. Uw overzicht bevat 3 kolommen Jaar, Maand, plantennaam, aantal. Sorteer op jaar, maand en plantennaam.

   **Opmerking:**
   - year(datum) geeft het jaartal uit de datum
   - month(datum) geeft het maandnummer uit de datum

    ```sql
    SELECT year(bestelDatum) as jaar, month(bestelDatum) as maand,
        plantNaam, count(*) as aantal
    FROM bestellijnen INNER JOIN bestellingen
    ON bestellijnen.bestelId = bestellingen.bestelId
    INNER JOIN artikelsLeveranciers
    ON bestellijnen.artikelLeverancierId = artikelsLeveranciers.artikelLeverancierId
    INNER JOIN planten
    ON planten.plantId = artikelsLeveranciers.plantId
    GROUP BY jaar, maand, plantNaam
    ORDER BY jaar, maand, plantNaam
    ```

6. Verhoog de prijs uit de tabel planten met 2% als de leveringstermijn kleiner is dan 7 dagen.
    ```sql
    UPDATE planten
    SET prijs = prijs * 1.02
    WHERE plantId IN (SELECT plantId FROM artikelsLeveranciers
    WHERE levertijd < 7)
    ```

7. Geef de namen van de leveranciers die maximaal twee soorten planten leveren.
    ```sql
    SELECT leverancierNaam
    FROM leveranciers INNER JOIN artikelsLeveranciers
    ON leveranciers.leverancierId = artikelsLeveranciers.leverancierId
    INNER JOIN planten
    ON artikelsLeveranciers.plantId = planten.plantId
    GROUP BY leverancierNaam
    HAVING count(DISTINCT soort) <= 2
    ORDER BY leverancierNaam, soort
    ```

8. Geef de namen van leveranciers die drie punten bevatten.
    ```sql
    SELECT leverancierNaam FROM leveranciers
    WHERE leverancierNaam LIKE '%.%.%.%'
    ```

9. ! Geef per leverancier de leveranciersnaam, de plantennaam en de offerteprijs van de duurste planten die hij levert.
    ```sql
    SELECT leverancierNaam, plantNaam, offertePrijs FROM planten
    INNER JOIN artikelsLeveranciers
    ON planten.plantId = artikelsLeveranciers.plantId
    INNER JOIN leveranciers
    ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
    WHERE offertePrijs = (SELECT max(offertePrijs) FROM artikelsLeveranciers
    WHERE artikelsLeveranciers.leverancierId = leveranciers.leverancierId)
    ORDER BY leverancierNaam, plantNaam
    ```

10. ! Toon de leveranciers die de meeste planten geleverd hebben. Toon de namen van de leveranciers en hoeveel planten zij leverden.

    WRONG:
    ```sql
    SELECT leverancierNaam, sum(aantal) AS aantalPlanten FROM bestellijnen
    INNER JOIN artikelsLeveranciers
    ON bestellijnen.artikelLeverancierId = artikelsLeveranciers.artikelLeverancierId
    INNER JOIN leveranciers
    ON artikelsLeveranciers.leverancierId = leveranciers.leverancierId
    GROUP BY leverancierNaam
    ORDER BY aantalPlanten DESC
    ```

    CORRECT:
    ```sql
    SELECT leverancierNaam, aantal
    FROM leveranciers INNER JOIN
    (SELECT leverancierId, count(*) as aantal
    FROM bestellingen INNER JOIN bestellijnen
    ON bestellingen.bestelId=bestellijnen.bestelId
    GROUP BY leverancierId) as subquery1
    ON leveranciers.leverancierId=subquery1.leverancierId
    WHERE aantal =
    (SELECT max(aantal) FROM
    (SELECT leverancierId, count(*) as aantal
    FROM bestellingen INNER JOIN bestellijnen
    ON bestellingen.bestelId=bestellijnen.bestelId
    GROUP BY leverancierId) as subquery2)
    ```

11. Geef een lijst van planten. Vermeld per plant de naam van de plant, hoogte, prijs en de tekst “DUUR, GOEDKOOP, GELIJK”, naargelang de prijs van de plant boven, onder of gelijk is aan het gemiddelde prijs van alle planten valt. Sorteer op prijs.
    ```sql
    SELECT plantNaam, hoogte, prijs, 'DUUR' FROM planten
    WHERE prijs > (SELECT avg(prijs) FROM planten)
    UNION
    SELECT plantNaam, hoogte, prijs, 'GOEDKOOP' FROM planten
    WHERE prijs < (SELECT avg(prijs) FROM planten)
    UNION
    SELECT plantNaam, hoogte, prijs, 'GELIJK' FROM planten
    WHERE prijs = (SELECT avg(prijs) FROM planten)
    ORDER BY prijs
    ```

12. ! Geef per soort het maximum prijs van de planten van die soort en hoeveel planten van die soort een prijs hebben gelijk aan dit maximum. Sorteer op soort.
    ```sql
    SELECT soort, prijs, count(*) AS aantal FROM planten
    WHERE prijs IN (SELECT max(prijs) FROM planten
    GROUP BY soort)
    GROUP BY soort
    ORDER BY soort
    ```

13. Verwijder alle gegevens uit de table artikelsleveranciers van de vaste planten die geleverd worden door de leverancier “TRA A.”.
    ```sql
    DELETE
    FROM artikelsLeveranciers
    WHERE plantId IN (SELECT plantId FROM planten
    WHERE soort = 'vast')
    AND leverancierId IN (SELECT leverancierId FROM leveranciers
    WHERE leverancierNaam = 'TRA A.')
    ```

14. Verhoog de offerteprijs van alle heesters met 2% als ze geleverd worden door een leverancier uit Lisse.
    ```sql
    UPDATE artikelsLeveranciers
    SET offertePrijs = offertePrijs * 1.02
    WHERE plantId IN (
        SELECT plantId FROM planten
        WHERE soort = 'heester')
    AND leverancierId IN (
        SELECT leverancierId FROM leveranciers
        WHERE woonplaats = 'lisse')
    ```

15. Verwijder alle bestellingen van de leverancier “ERICA BV.”
    ```sql
    DELETE
    FROM bestellingen
    WHERE leverancierId = (
        SELECT leverancierId FROM leveranciers
        WHERE leverancierNaam = 'ERICA BV.')
    ```
