-- ============================================================
-- 1. POPOLAMENTO TABELLE ANAGRAFICHE (DML)
-- Questi comandi estraggono i dati univoci dalla tabella temporanea
-- ============================================================

-- Inserimento Hotel
INSERT INTO hotels (hotel_name, hotel_address, lat, lng)
SELECT DISTINCT Hotel_Name, Hotel_Address, lat, lng 
FROM hotel_reviews_temp;

-- Inserimento Nazionalità Recensori
INSERT INTO reviewers (reviewer_nationality)
SELECT DISTINCT Reviewer_Nationality 
FROM hotel_reviews_temp;

-- Inserimento Statistiche Hotel
INSERT INTO hotel_stats (hotel_id, average_score, total_reviews)
SELECT h.hotel_id, MAX(t.Average_Score), MAX(t.Total_Number_of_Reviews)
FROM hotels h
JOIN hotel_reviews_temp t ON h.hotel_name = t.Hotel_Name
GROUP BY h.hotel_id;


-- ============================================================
-- 2. POPOLAMENTO TABELLA REVIEWS (PIPELINE PYTHON)
-- Data la mole di dati (513.812 righe), il caricamento della 
-- tabella 'reviews' è stato gestito tramite SQLAlchemy in Python
-- per garantire l'integrità e prevenire il timeout del database.
-- Troverete il codice utilizzato per farlo nel file 02_SQL_PIPELINE_LOAD.ipynb.
-- ============================================================













