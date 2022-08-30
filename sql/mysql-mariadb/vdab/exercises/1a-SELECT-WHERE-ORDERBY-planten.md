# SELECT - WHERE - ORDER BY
## Database planten
1. Geef een overzicht, met alle gegevens, van de leveranciers uit Aalsmeer.
    ```sql
    SELECT * FROM leveranciers
    WHERE woonplaats='aalsmeer'
    ```

2. Geef een alfabetisch overzicht op plantennaam, met plantId, plantennaam en prijs, van alle planten.
    ```sql
    SELECT plantId, plantNaam, prijs
    FROM planten
    ORDER BY plantNaam
    ```

3. Welke planten beginnen in de maand maart te bloeien?
   Toon plantId, plantennaam, en de beginmaand van de bloeiperiode.
    ```sql
    SELECT plantId, plantNaam, beginBloeiMaand 
    FROM planten
    WHERE beginBloeiMaand=3
    ```

4. Maak een overzicht uit de table 'artikelsleveranciers', gesorteerd op plantId en binnen plantId een sortering op artikelcode van de leverancier.
   Toon alleen de gegevens plantId, artikelcode van de leverancier en leverancierId.
    ```sql
    SELECT plantId, artikelLeverancierCode, leverancierId
    FROM artikelsleveranciers
    ORDER BY plantId, artikelLeverancierCode
    ```

5. Maak een gesorteerd overzicht van alle waterplanten. Sorteer op hoogte, grootste voorop.
    ```sql
    SELECT * FROM planten
    WHERE soort='water'
    ORDER BY hoogte desc
    ```

6. Maak een lijst van de verschillende kleuren die bij de planten uit de table planten horen.
    ```sql
    SELECT DISTINCT kleur FROM planten
    ORDER BY kleur
    ```

7. Maak een lijst van alle planten waarvan de kolom kleur niet ingevuld is.
    ```sql
    SELECT * FROM planten
    WHERE kleur IS NULL
    ```

8. Toon de verschillende soorten planten in de table 'planten'.
    ```sql
    SELECT DISTINCT soort FROM planten
    ```

9. Geef een overzicht van alle vaste planten met gele bloemen. Van iedere plant toon je de volgende gegevens: plantId, plantennaam, hoogte en de beginmaand van de bloeiperiode.
    ```sql
    SELECT plantId, plantNaam, hoogte, beginBloeiMaand
    FROM planten
    WHERE kleur='geel' and soort='vast'
    ```

10. Geef een overzicht van alle planten met een prijs boven de 10 € die niet tot de soort bomen behoren.
    ```sql
    SELECT * FROM planten
    WHERE prijs > 10 and soort <> 'boom'
    ```

11. Maak een lijst van alle planten die in juni beginnen te bloeien en witte bloemen geven en tevens van alle planten die in augustus voor het eerst bloeien en gele bloemen hebben.
   Plaats alle beschikbare gegevens in het overzicht.
    ```sql
    SELECT * FROM planten
    WHERE (beginBloeiMaand=6 and kleur='wit') or (beginBloeiMaand=8 and kleur='geel')
    ```

12. Welke planten met gemengde bloeikleuren worden maximum 60 cm hoog?
    Toon plantId, plantennaam en hoogte.
    ```sql
    SELECT plantId, plantNaam, hoogte
    FROM planten
    WHERE kleur = 'gemengd' and hoogte <= 60
    ```

13. Geef een overzicht van alle leveranciers die niet in Hillegom wonen.
    ```sql
    SELECT * FROM leveranciers
    WHERE woonplaats <> 'Hillegom'
    ```

14. Van welke planten is de kleur onbekend? Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE kleur IS NULL
    ```

15. Welke planten bloeien in ieder geval in de ganse periode augustus tot en met oktober?
    Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE eindBloeiMaand >= 10 and beginBloeiMaand <= 8
    ```

16. Welke planten bloeien in ieder geval in de maand september? Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE eindBloeiMaand >= 9 and beginBloeiMaand <= 9
    ```

17. Geef een overzicht van alle vaste planten met een prijs tussen €3 en €5.
    ```sql
    SELECT * FROM planten
    WHERE soort='vast' and prijs between 3 and 5
    ```

18. Geef een overzicht van alle planten die in maart, april, september of oktober beginnen te bloeien.
    ```sql
    SELECT * FROM planten
    WHERE beginBloeiMaand in (3,4,9,10)
    ```

19. Van welke planten is zowel de kleur als de hoogte onbekend? Geef plantId, plantennaam, kleur en hoogte.
    ```sql
    SELECT plantId, plantNaam, kleur, hoogte
    FROM planten
    WHERE kleur IS NULL AND hoogte IS NULL
    ```

20. Bij welke planten komt het woord BOOM voor? Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like '%boom%'
    ```

21. Geef plantId en plantennaam van alle planten die als derde letter een 'N' hebben.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like '__n%'
    ```

22. Welke 1- en 2-jarige planten staan er in de table 'planten'?
    Probeer deze vraag met en zonder de operator like op te lossen.
    ```sql
    -- Zonder like:
    SELECT * FROM planten
    WHERE soort in ('1-jarig', '2-jarig');

    -- Met like:
    SELECT * FROM planten
    WHERE soort like '_-jarig'
    ```

23. Geef een overzicht van alle planten, behalve de bomen en de heesters, die tussen de 100 en 200 cm hoog zijn, rode of blauwe bloemen geven, en vóór augustus beginnen te bloeien.
    Alle gegevens behalve de prijs zijn belangrijk.
    Sorteer de lijst op 'soort' en binnen soort op 'plantennaam'.
    ```sql
    SELECT plantId, plantNaam, soort, kleur,
    hoogte, beginBloeiMaand, eindBloeiMaand
    FROM planten
    WHERE soort not in ('boom', 'heester') AND hoogte between 100 and 200
    AND kleur in ('rood', 'blauw') AND beginBloeiMaand < 8
    ORDER BY soort, plantNaam
    ```

24. Bij welke planten, die niet behoren tot de soort kruid, komt het woord KRUID voor in hun plantennaam?
    Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like '%kruid%' and soort <> 'kruid'
    ```

25. Geef plantId en plantennaam van alle planten die beginnen met de letter 'L' en eindigen met de letter 'E'.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like 'l%e'
    ```

26. Welke planten hebben een plantennaam van precies 5 letters lang? Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like '_____'
    ```

27. Welke planten hebben een plantennaam van minimum 5 letters lang? Geef plantId en plantennaam.
    ```sql
    SELECT plantId, plantNaam FROM planten
    WHERE plantNaam like '_____%'
    ```

