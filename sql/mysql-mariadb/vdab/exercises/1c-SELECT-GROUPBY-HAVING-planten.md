# SELECT - GROUP BY - HAVING
## Database planten
1. Tel het aantal planten per plantensoort uit de table 'planten'.
    ```sql
    SELECT soort, count(*) as aantal
    FROM planten
    GROUP BY soort
    ```

2. Tel het aantal bestelregels per bestelling.
    ```sql
    SELECT bestelId, count(*) as aantal
    FROM bestellijnen
    GROUP BY bestelId
    ```

3. Wat is de gemiddelde prijs per plantensoort?
    ```sql
    SELECT soort, avg(prijs) as gemiddelde
    FROM planten
    GROUP BY soort
    ```

4. Hoeveel planten zijn er per plantensoort-kleurgroep?
    ```sql
    SELECT soort, kleur, count(*) as aantal
    FROM planten
    GROUP BY soort, kleur
    ```

5. Maak een overzicht zodat duidelijk is welke kleur van de vaste planten de hoogste gemiddelde prijs heeft.
    ```sql
    SELECT kleur, avg(prijs) as gemiddelde
    FROM planten
    WHERE soort = 'vast'
    GROUP BY kleur
    ORDER BY 2 DESC
    ```

6. Laat per leveranciersId het aantal artikelen zien dat de leverancier aanbiedt onder voorwaarde dat de levertijd van het artikel minder dan 18 dagen is.
    ```sql
    SELECT leverancierId, count(*) as aantal
    FROM artikelsleveranciers
    WHERE levertijd < 18
    GROUP BY leverancierId
    ```

7. Wat is de gemiddelde prijs per plantensoort, exclusief de geelbloemige planten?
    ```sql
    SELECT soort, avg(prijs) as gemiddelde
    FROM planten
    WHERE kleur <> 'geel'
    GROUP BY soort
    ```

8. Maak een overzicht met de laagste en de hoogste offerteprijs per plant.
    ```sql
    SELECT plantId, min(offerteprijs) as mini, max(offerteprijs) as maxi
    FROM artikelsleveranciers
    GROUP BY plantId
    ```

9. Wat is de gemiddelde prijs per plantensoort voor soorten met minstens 10 exemplaren in de table 'planten'?
    ```sql
    SELECT soort, avg(prijs) as gemiddelde
    FROM planten
    GROUP BY soort
    HAVING count(*) >= 10
    ```

10. Hebben de planten met korte levertijden in het algemeen een hogere gemiddelde offerteprijs?
    ```sql
    SELECT levertijd, avg(offerteprijs) as gemiddelde
    FROM artikelsleveranciers
    GROUP BY levertijd
    ```

11. Maak een overzicht met de laagste en de hoogste bestelprijs per artikelLeverancierId.
    ```sql
    SELECT artikelLeverancierId, min(bestelprijs) as laagste,
      max(bestelprijs) as hoogste
    FROM bestellijnen
    GROUP BY artikelLeverancierId
    ```

12. Geef een overzicht van het aantal beschikbare planten per beginBloeiMaand/hoogte/kleur groep.
    ```sql
    SELECT beginBloeiMaand, hoogte, kleur, count(*) as aantal
    FROM planten
    GROUP BY beginBloeiMaand, hoogte, kleur
    ```

13. Wat is de laagste prijs per plantensoort van de planten die in ieder geval bloeien in de ganse periode mei tot en met juni?
    ```sql
    SELECT soort, min(prijs) as minimum
    FROM planten
    WHERE eindBloeiMaand > 6 and beginBloeiMaand < 5
    GROUP BY soort
    ```

14. Tel het aantal planten per prijs. De prijs moet je afronden op een geheel getal.  
    **TIP:** Om een waarde af te ronden, kan je de function 'round' gebruiken: `round(getal, 1)` rondt een getal af op 1 cijfer na de komma.
    ```sql
    SELECT round(prijs, 0) as afgeronde_prijs, count(*) as aantal
    FROM planten
    GROUP BY round(prijs, 0)
    ```
