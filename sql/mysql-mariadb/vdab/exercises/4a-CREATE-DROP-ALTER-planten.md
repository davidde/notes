# CREATE - DROP - ALTER
## Database planten
1. Creëer een table 'klachten' met de volgende velden:

    | veld     | data-type   | lengte   |
    |----------|-------------|----------|
    | klachtId | numeriek    |          |
    | plantId  | numeriek    |          |
    | datum    | datum       |          |
    | klacht   | karakter    | 100      |
    | status   | karakter    | 2        |

    Voeg nadien volgende klacht toe aan deze table:  
    Klacht nr. 1 heeft betrekking op plantid 10. De klacht luidt : “Planten (leveranciercode 2) verkocht op 14-1-2016 vertoonden bruine vlekken na circa 2 maanden”.
    De status is GL (gemeld aan leverancier) en de klacht wordt ingebracht op 15-3-2016.

    ```sql
    CREATE TABLE klachten
    (klachtId integer,
    plantId integer,
    datum datetime,
    klacht varchar(100),
    status char(2));

    INSERT INTO klachten
    VALUES (1, 10, '2016/03/15', 'Planten (leveranciercode 2) verkocht op 14-1-2016 vertoonden bruine vlekken na circa 2 maanden', 'GL')
    ```

2. Er is behoefte aan een table 'aanbied' waaruit snel de goedkoopste leveranciers van de planten uit de table 'planten' kunnen worden opgezocht.

    De table heeft de volgende kolommen: plantId, plantNaam, leverancierId en offerteprijs.
    Vul deze table vanuit de tables 'planten' en 'artikelsleveranciers'.

    ```sql
    CREATE TABLE aanbied
    AS SELECT planten.plantId, plantNaam, a1.leverancierId, offertePrijs
    FROM artikelsleveranciers a1 INNER JOIN planten ON a1.plantId = planten.plantId
    WHERE offertePrijs = (SELECT min(offertePrijs) FROM artikelsleveranciers a2 WHERE a2.plantId = a1.plantId)
    ```

3. Breid de table 'planten' uit met een kolom 'voorraad' om het aantal stuks dat het tuincentrum nog in voorraad heeft bij te houden.
    ```sql
    ALTER TABLE planten
    ADD voorraad integer
    ```

4. Definieer de foreign keys van de table 'artikelsleveranciers'.
    ```sql
    ALTER TABLE artikelsleveranciers
    ADD CONSTRAINT f_plantId foreign key (plantId) references planten (plantId);

    ALTER TABLE artikelsleveranciers
    ADD CONSTRAINT f_leverancierId foreign key (leverancierId) references leveranciers (leverancierId);
    ```

5. Maak een index 'BSRIDX01' op de samengestelde sleutel 'bestelId' en 'artikelLeverancierId' van de table 'bestellijnen'.
    ```sql
    CREATE INDEX bsridx01
    ON bestellijnen (bestelId, artikelLeverancierId)
    ```

6. De table artikelsleveranciers wordt regelmatig gejoind met de tables 'planten', 'leveranciers' en 'bestellijnen'.
   Welke indexen zijn waardevol voor de table 'artikelsleveranciers'?
    ```sql
    CREATE INDEX i_plantId
    ON artikelsleveranciers (plantId)

    CREATE INDEX i_leverancierId
    ON artikelsleveranciers (leverancierId)
    ```

