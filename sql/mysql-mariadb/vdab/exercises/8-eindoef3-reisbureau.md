# Database Reisbureau
## Gegevens selecteren
1. Selecteer de contactgegevens van alle klanten uit West-Vlaanderen, gesorteerd volgens gemeentenaam en familienaam.
    ```sql
    SELECT * FROM tblKlanten
    WHERE provincie = 'w-vl'
    ORDER BY gemeente, naam
    ```

2. Welke klanten hebben geen gsm-nummer opgegeven?
    ```sql
    SELECT * FROM tblKlanten
    WHERE gsm IS NULL or gsm = ''
    ```

3. Ga na hoeveel boekingen elke reis heeft. Bereken ook hoeveel volwassenen en hoeveel kinderen per bestemming meereizen. Het resultaat toont informatie over de reis (ReisID, werelddeel, land, plaats, vertrekdatum, aantal dagen) en informatie over de boeking (aantal boekingen, aantal volwassenen, aantal kinderen).
    ```sql
    SELECT ReisID, werelddeel, land, plaats, vertrekdatum, aantalDagen, count(*) AS aantalBoekingen, aantalVolwassenen, aantalKinderen
    FROM tblReis INNER JOIN tblBestemming ON tblReis.bestemmingcode = tblBestemming.bestemmingsID
    INNER JOIN tblBoeking ON tblReis.reisID = tblBoeking.reisNummer
    GROUP BY reisId
    ORDER BY reisId
    ```

4. Bereken de gemiddelde prijs van een reis per continent.
    ```sql
    SELECT werelddeel, avg(prijsPerPersoon) FROM tblBestemming
    INNER JOIN tblReis ON tblBestemming.bestemmingsID = tblReis.bestemmingCode
    GROUP BY werelddeel
    ```

5. Bereken hoeveel elke klant voor zijn/haar reis moeten betalen. De prijs van een boeking is het product van het aantal volwassen personen en de prijs per persoon. Alleen volwassenen moeten betalen, kinderen (< 12) mogen (voorlopig) gratis mee. Het resultaat geeft informatie over de boeking (Boekingsnummer, boekdatum), de klant (Klantnummer, Naam) en het verschuldigde bedrag. Hou je ook rekening met het voorschot?
    ```sql
    SELECT boekingNummer, boekDatum, klantNummer, naam,
    (aantalVolwassenen * prijsPerPersoon - betaaldBedrag) AS verschuldigdBedrag
    FROM tblReis INNER JOIN tblBoeking ON tblReis.reisID = tblBoeking.reisNummer
    INNER JOIN tblKlanten ON tblBoeking.klantNummer = tblKlanten.klantID
    ```

6. Geef elke klant een label op basis van aantal kinderen (in tblBoeking): kinderloos, modaal gezin of groot gezin. Vanaf 3 kinderen krijgt de klant het label groot gezin.
    ```sql
    SELECT boekingNummer, klantNummer, 'kinderloos' AS label
    FROM tblBoeking WHERE kinderen = 0
    UNION
    SELECT boekingNummer, klantNummer, 'modaal gezin' AS label
    FROM tblBoeking WHERE kinderen IN (1, 2)
    UNION
    SELECT boekingNummer, klantNummer, 'groot gezin' AS label
    FROM tblBoeking WHERE kinderen > 2
    ```

7. Geef alle gegevens van de langste reizen.
    ```sql
    SELECT * FROM tblReis
    WHERE aantalDagen =
    (SELECT max(aantalDagen)
    FROM tblReis)
    ```

## Gegevens aanpassen en beheren
1. Voeg je eigen gegevens toe aan de tabel tblPersoneelsleden. Jouw personeelsnummer is 1053.
    ```sql
    INSERT INTO tblPersoneelsleden
    VALUES ('1053', 'Deprost', 'David', 'Kammerstraat 16', '9000', 'Gent', '093689989', '0495246517',
    'david.deprost@vdabcampus.be', '1986-12-19', '2022-9-2', 0, '461-3192284-74', '2500')
    ```

2. Verwijder alle personeelsleden die niet meer in dienst zijn. Maak wel eerst een reservekopie in een tabel tblExPersoneel.Tip: Denk eraan: -1 is ja, 0 is nee.
    ```sql
    CREATE TABLE tblExPersoneel
    AS
    SELECT * FROM tblPersoneelsleden
    WHERE inDienst = 0;

    DELETE
    FROM tblPersoneelsleden
    WHERE inDienst = 0
    ```

3. Verhoog de prijs voor de reizen naar Centraal-Amerika met 2%.
    ```sql
    UPDATE tblReis
    SET prijsPerPersoon = prijsPerPersoon * 1.02
    WHERE bestemmingCode IN (
    SELECT bestemmingsID FROM tblBestemming
    WHERE werelddeel = 'Centraal Amerika')
    ```

4. Leg alle relaties. Definieer de nodige sleutels.
    ```sql
    ALTER TABLE tblReis
    ADD CONSTRAINT f_bestemmingCode FOREIGN KEY (bestemmingCode) REFERENCES tblBestemming (bestemmingsId);

    ALTER TABLE tblReis
    ADD CONSTRAINT f_reisId FOREIGN KEY (reisId) REFERENCES tblBoeking (reisNummer);

    ALTER TABLE tblBoeking
    ADD CONSTRAINT f_klantNummer FOREIGN KEY (klantNummer) REFERENCES tblKlanten (klantId);
    ```


## Extra
1. Alle klanten die als reisbestemming een Aziatisch, Zuid-Amerikaans of Afrikaans land hebben, krijgen binnenkort een brief in de bus waarin gevraagd wordt om zich tijdig te laten vaccineren tegen tropische ziekten. Selecteer de nodige adresgegevens. Sorteer op Land en plaats.
    ```sql
    SELECT naam, voornaam, straat, postnr, gemeente, land AS bestemmingsLand, plaats AS bestemmingsPlaats
    FROM tblKlanten INNER JOIN tblBoeking ON tblKlanten.klantId = tblBoeking.klantNummer
    INNER JOIN tblReis ON tblBoeking.reisNummer = tblReis.reisId
    INNER JOIN tblBestemming ON tblReis.bestemmingCode = tblBestemming.bestemmingsID
    WHERE werelddeel IN ('azie', 'afrika', 'zuid amerika')
    ORDER BY bestemmingsLand, bestemmingsPlaats
    ```

2. Ga na welke groepen in het weekend op reis vertrekken. Zij krijgen later een aangepaste dienstregeling van het openbaar vervoer opgestuurd. Voorzie dus alle contactgegevens. Tip: Gebruik de functie WEEKDAY. (In SQLtryout is zondag dag 1, in MySQL is maandag dag 1)
    ```sql
    SELECT naam, voornaam, straat, postnr, gemeente, telefoonnummer, faxnummer, gsm, mailadres
    FROM tblKlanten INNER JOIN tblBoeking ON tblKlanten.klantId = tblBoeking.klantNummer
    INNER JOIN tblReis ON tblBoeking.reisNummer = tblReis.reisId
    WHERE weekday(vertrekDatum) IN (6, 7)
    ```

3. De prijs van alle reizen naar Noord-Amerika worden volgend jaar een kwart duurder. Ga na welke gevolgen dit zal hebben op de prijs. Het resultaat geeft naast de reisbestemming (Werelddeel, land, plaats) ook de oude en de nieuwe prijs weer.
    ```sql
    SELECT werelddeel, land, plaats, prijsPerPersoon AS oudePrijs,
    (prijsPerPersoon * 1.25) as nieuwePrijs
    FROM tblReis INNER JOIN tblBestemming
    ON tblReis.bestemmingCode = tblBestemming.bestemmingsId
    WHERE werelddeel = 'noord amerika'
    ```

4. Geef een lijst van alle klanten (naam, voornaam en bestemming). Ook klanten die nog geen boeking gedaan hebben moeten in deze lijst staan.
    ```sql
    SELECT naam, voornaam, land AS bestemmingsLand, plaats AS bestemmingsStad
    FROM tblKlanten
    LEFT JOIN tblBoeking ON tblKlanten.klantId = tblBoeking.klantNummer
    LEFT JOIN tblReis ON tblBoeking.reisNummer = tblReis.reisId
    LEFT JOIN tblBestemming ON tblReis.bestemmingCode = tblBestemming.bestemmingsId
    ```
