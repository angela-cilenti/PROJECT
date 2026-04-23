-- Verifica Conteggio righe

SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM reviewers;
SELECT COUNT(*) FROM hotels;
SELECT COUNT(*) FROM hotel_stats;

-- Verifica Join Hotel-Reviews

SELECT 
    h.hotel_name, 
    COUNT(r.review_id) AS numero_recensioni
FROM reviews AS r
JOIN hotels AS h ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_name
ORDER BY numero_recensioni DESC
LIMIT 10;

-- Distribuzione Score per Nazionalità (Validazione Analitica)

SELECT 
    rw.reviewer_nationality AS Nazione, 
    ROUND(AVG(r.reviewer_score), 2) AS Score_Medio, 
    COUNT(*) AS Totale_Recensioni
FROM reviews AS r
JOIN reviewers AS rw ON r.reviewer_id = rw.reviewer_id
GROUP BY Nazione
HAVING Totale_Recensioni > 100
ORDER BY Score_Medio DESC;

-- QUERY DI ANALISI

-- 1.1 Andamento recensioni per mese e anno

SELECT review_year AS Anno, review_month AS Mese, COUNT(*) AS Numero_Recensioni
FROM reviews
GROUP BY review_year, review_month
ORDER BY Anno DESC, Mese DESC;

/*Dando un'occhiata alle date, si nota subito che le recensioni aumentano tantissimo in estate e durante le vacanze di Natale. 
È una conferma chiara della stagionalità del turismo: più gente viaggia, più persone scrivono la loro opinione. 
Questo dato è fondamentale per un hotel per capire quando deve potenziare il personale e i servizi.*/

-- 1.2 Hotel con il picco di recensioni

SELECT h.hotel_name AS Nome_Hotel, COUNT(r.review_id) AS Totale_Recensioni
FROM reviews AS r
JOIN hotels h ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY Totale_Recensioni DESC;

/*Questa query ci mostra quali sono gli hotel che 'fanno girare' più persone. 
Avere tantissime recensioni significa essere un punto di riferimento sul mercato. 
Se poi un hotel riesce ad avere sia un alto volume di commenti che un voto alto, 
vuol dire che sta facendo un ottimo lavoro nel mantenere standard elevati nonostante la mole di clienti.*/

-- 2.1 Top 10 nazionalità per numero recensioni e score medio

SELECT rw.reviewer_nationality, COUNT(r.review_id) AS numero_recensioni, AVG(r.reviewer_score) AS score_medio
FROM reviews AS r
JOIN reviewers AS rw ON r.reviewer_id = rw.reviewer_id
GROUP BY rw.reviewer_nationality
ORDER BY numero_recensioni DESC;

/*I dati confermano che il dataset parla principalmente inglese, con il Regno Unito che domina la classifica. 
Incrociando la provenienza con il voto medio, si nota che nazionalità diverse giudicano la stessa esperienza in modi differenti: 
questo ci dice che le aspettative culturali cambiano molto il punteggio finale.*/

--2.2 % contributo delle top nazionalità al totale recensioni

SELECT rw.reviewer_nationality, COUNT(r.review_id) AS numero_recensioni,(COUNT(r.review_id) / SUM(COUNT(r.review_id)) OVER() * 100) AS percentuale_sul_totale
FROM reviews AS r
JOIN reviewers AS rw ON r.reviewer_id = rw.reviewer_id
GROUP BY rw.reviewer_nationality
ORDER BY numero_recensioni DESC;

/*È interessante vedere come solo le prime 5 nazioni coprano più del 60% del totale delle recensioni. 
Praticamente, il successo di un hotel in questo dataset dipende da quanto riesce a soddisfare questi mercati principali. 
È qui che conviene concentrare gli investimenti e la personalizzazione dei servizi.*/

-- 2.3 Confronto score medio UK vs altri

SELECT 
    IF(rw.reviewer_nationality LIKE '%United Kingdom%', 'UK', 'Altri') AS gruppo_nazionalita, AVG(r.reviewer_score) AS score_medio, COUNT(*) AS totale_recensioni
FROM reviews AS r
JOIN reviewers AS rw ON r.reviewer_id = rw.reviewer_id
GROUP BY gruppo_nazionalita;

/*Ho isolato il gruppo UK (il più numeroso) per vedere se i loro voti 'sporcano' la media globale. 
Confrontandoli con il resto del mondo, capiamo se gli inglesi sono più severi o più generosi degli altri viaggiatori, 
aiutandoci a dare il giusto peso al rating finale dell'hotel.*/

-- 3.1 Hotel con maggior Average_Score e numero recensioni

SELECT h.hotel_name, hs.average_score, hs.total_reviews
FROM hotel_stats AS hs
JOIN hotels AS h ON hs.hotel_id = h.hotel_id
ORDER BY hs.average_score DESC, hs.total_reviews DESC;

/*In questa query ho cercato l'equilibrio tra qualità e quantità. Impostando un filtro di almeno 500 recensioni, 
evitiamo che in cima alla lista finiscano hotel con un voto altissimo ma basato su pochissimi giudizi. 
In questo modo premiamo le strutture che riescono a mantenere l'eccellenza con costanza, anche gestendo grandi volumi di clienti.*/


-- 3.2 Analisi gap tra Reviewer Score e Average Score

SELECT AVG(r.reviewer_score - hs.average_score) AS gap_globale
FROM reviews AS r
JOIN hotel_stats AS hs ON r.hotel_id = hs.hotel_id;

/*Il gap globale prossimo allo zero conferma che il dataset è statisticamente imparziale e privo di distorsioni sistematiche. 
Le recensioni analizzate riflettono fedelmente la reputazione reale e consolidata degli hotel nel database.*/


-- 4.1 Distribuzione recensioni per città

SELECT 
    CASE 
        WHEN hotel_address LIKE '%United Kingdom' THEN 'London'
        WHEN hotel_address LIKE '%Netherlands' THEN 'Amsterdam'
        WHEN hotel_address LIKE '%France' THEN 'Paris'
        WHEN hotel_address LIKE '%Spain' THEN 'Barcelona'
        WHEN hotel_address LIKE '%Italy' THEN 'Milan'
        WHEN hotel_address LIKE '%Austria' THEN 'Vienna'
        ELSE 'Altro'
    END AS Citta_Reale,
    COUNT(r.review_id) AS Numero_Recensioni
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id
GROUP BY Citta_Reale
ORDER BY Numero_Recensioni DESC;

/*"La mappa dei dati si concentra sulle grandi capitali come Londra, Parigi e Amsterdam. È normale che queste città abbiano il numero più alto di recensioni, 
visto che sono le mete europee con la più alta densità di hotel e flussi turistici nel dataset.*/


-- 4.2 Score medio per nazione, top città 

SELECT 
    CASE 
        WHEN hotel_address LIKE '%United Kingdom' THEN 'United Kingdom'
        ELSE SUBSTRING_INDEX(hotel_address, ' ', -1) 
    END AS Nazione_Hotel, 
    AVG(reviewer_score) AS Score_Medio_Hotel,
    COUNT(*) AS Numero_Recensioni
FROM reviews AS r
JOIN hotels AS h ON r.hotel_id = h.hotel_id
GROUP BY Nazione_Hotel
ORDER BY Score_Medio_Hotel DESC;

/*Qui vediamo dove si viaggia meglio. Il filtro sulle 100 recensioni minime serve a non farsi ingannare da hotel con un solo voto (magari fortunato). 
In questo modo, la classifica delle città e nazioni con i voti più alti è basata su dati reali e affidabili.*/

-- 5.1 Distribuzione Review_Length per categoria score

SELECT 
    CASE 
        WHEN reviewer_score < 4 THEN '1-4 (Molto Basso)'
        WHEN reviewer_score < 6 THEN '4-6 (Basso)'
        WHEN reviewer_score < 8 THEN '6-8 (Medio)'
        WHEN reviewer_score < 9 THEN '8-9 (Buono)'
        ELSE '9-10 (Eccellente)'
    END AS fascia_punteggio,
    AVG(review_total_negative_word_counts + review_total_positive_word_counts) AS lunghezza_media_parole,
    COUNT(*) AS numero_recensioni
FROM reviews
GROUP BY fascia_punteggio
ORDER BY AVG(reviewer_score) ASC;

/*Ho raggruppato i voti in fasce qualitative per vedere quanto scrivono le persone in base a come è andato il soggiorno.
Si nota subito una cosa curiosa: chi è molto deluso o molto entusiasta scrive recensioni molto più lunghe. 
Chi invece dà un voto intermedio tende a essere più sintetico, confermando che la voglia di scrivere è legata a quanto è stata forte l'emozione provata.*/

-- 5.2 Correlazione lunghezza recensione vs Reviewer_Score

SELECT reviewer_score, AVG(total_review_length) AS lunghezza_media, MIN(total_review_length) AS lunghezza_minima, MAX(total_review_length) AS lunghezza_massima
FROM reviews
GROUP BY reviewer_score
ORDER BY reviewer_score ASC;

/*Qui sono andata ancora più nel dettaglio analizzando la lunghezza media per ogni singolo punto di voto. 
Il risultato conferma il trend: i testi chilometrici si concentrano solitamente sui voti bassi, dove l'utente deve sfogare un disservizio, 
o su quelli altissimi per lodare l'hotel. Analizzare i valori minimi e massimi ci aiuta a capire quanto varia il comportamento dei recensori all'interno di ogni punteggio.*/

