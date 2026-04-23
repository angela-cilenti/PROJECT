**HOTEL E REVIEWS ANALYSIS: DATA PIPELINE & VISUALIZATION**

**DESCRIZIONE DEL PROGETTO**

Questo progetto analizza un dataset di oltre 515.000 recensioni relative a 1.493 hotel di lusso in Europa nel periodo 2015-2017. 
L'obiettivo principale è stato costruire una pipeline completa: dalla pulizia dei dati grezzi su Python, 
al popolamento di un database relazionale SQL, fino alla validazione e visualizzazione finale dei risultati.

**TECNOLOGIE UTILIZZATE**

**Python (Pandas, Matplotlib, Seaborn):** Per l'analisi dei dati e la visualizzazione.

**SQL (MariaDB/MySQL):** Per la progettazione dello schema relazionale e le query analitiche.

**SQLAlchemy:** Per la sincronizzazione e il caricamento dei dati tra Python e SQL.

**FASI DEL PROGETTO**

*1. Preparazione e Pulizia dei Dati (Python)*

- Gestione dei valori mancanti e rimozione dei duplicati esatti.
- Conversione temporale e feature engineering (estrazione Anno/Mese).
- Esportazione del dataset normalizzato: hotel_reviews_clean.csv.

*2. Progettazione Database SQL*

- Creazione di uno schema relazionale ottimizzato composto dalle tabelle: hotels, reviewers, reviews e hotel_stats.
- Configurazione di Primary Keys e Foreign Keys per garantire l'integrità referenziale.
- Popolamento del database tramite pipeline Python automatizzata.

*3. Analisi Cross-Platform (SQL vs Pandas)*

Abbiamo riprodotto le stesse query analitiche su entrambi i sistemi per validare la coerenza dei dati:

**Analisi Temporale:** Trend mensili e annuali del volume di recensioni.

**Geografia & Nazionalità:** Ranking dei mercati dominanti (UK vs Resto del mondo) e distribuzione per città europee.

**Performance:** Correlazione tra punteggi assegnati e verbosità (lunghezza) dei testi.

**Feature Engineering Avanzata:** Sentiment base e Clustering delle città per qualità percepita.

*4. Visualizzazione Dati*

Sono stati generati e salvati 8 grafici PNG ad alta risoluzione che mostrano:
- Andamento cronologico delle recensioni (Line Plot).
- Distribuzione geografica per nazionalità e città (Bar Charts).
- Variabilità degli score tra le top nazioni (Box Plots).
- Correlazioni tra variabili numeriche (Heatmap e Scatter Plots).

**STRUTTURA DEL REPOSITORY**

PROJECT/

├── 01_EDA_CLEANING.ipynb          # Pulizia dati e variabili derivate

├── 02_ANALYSIS_PANDAS_PLOTS.ipynb # Analisi avanzata e visualizzazioni

├── CREATE_TABLES.sql              # Script creazione schema database

├── INSERT_DATA.sql                # Script popolamento 

├── ANALYSIS_QUERIES.sql           # Raccolta delle query SQL di analisi

├── DATASET.csv                    # Versione pulita del dataset per SQL

├── FINAL_REPORT.pdf               # Relazione finale con insight e conclusioni

└── README.md                      # Istruzioni e documentazione

**INSIGHT E CONCLUSIONI ANALITICHE**

L'analisi integrata dei dati ha permesso di estrarre evidenze strategiche sul comportamento dei viaggiatori e sulla qualità dell'offerta alberghiera europea:

**Il Fattore Londra e il Mercato UK:** Londra non è solo la città più presente nel dataset, ma i viaggiatori britannici rappresentano quasi il 48% della contribuzione totale. 
Questo indica che il sentiment globale del dataset è fortemente influenzato dagli standard e dalle aspettative del mercato anglosassone.

**Eccellenza Continentale:** Nonostante i volumi inferiori, le città di Vienna e Barcellona (e in generale Austria e Spagna) 
mostrano punteggi medi costantemente più alti rispetto a Londra e Parigi. Questo suggerisce un'efficienza superiore o una percezione di "valore per il prezzo" più favorevole nelle destinazioni continentali e mediterranee.

**Psicologia del Recensore:** La correlazione inversa tra punteggio e verbosità è netta: le recensioni negative (fascia 1-4) hanno una lunghezza media di 57 parole, 
contro le 31 parole di quelle eccellenti (fascia 9-10). Chi vive un'esperienza negativa sente il bisogno di giustificare il proprio voto con dettagli minuziosi, mentre il cliente soddisfatto tende alla sintesi.

**Sentiment e Coerenza:** L'indice di Sentiment Base creato ha confermato che, nonostante i critici siano più rumorosi, la "pancia" del mercato è ampiamente positiva, con una stabilità dei voti che riflette una gestione professionale e consolidata degli hotel di lusso analizzati.
