# Hotel & Reviews Analysis: Data Pipeline & Visualization

## Descrizione del Progetto
Questo progetto analizza un dataset di oltre **515.000 recensioni** relative a 1.493 hotel di lusso in Europa (2015-2017). 
L'obiettivo è la costruzione di una pipeline end-to-end: dalla pulizia dei dati grezzi in Python, al popolamento di un database relazionale SQL, fino alla generazione di insight strategici tramite data visualization.

## Tecnologie Utilizzate
*   **Python:** Pandas, Matplotlib, Seaborn (Analisi e Visualizzazione).
*   **SQL (MariaDB/MySQL):** Progettazione schema relazionale e query analitiche.
*   **SQLAlchemy:** Integrazione e automazione del flusso dati Python-SQL.

## Fasi del Progetto

### 1. Data Preparation & Cleaning (Python)
- Gestione valori mancanti e rimozione duplicati.
- Feature Engineering: estrazione temporale (Anno/Mese) e normalizzazione del testo.
- Esportazione dataset ottimizzato: `hotel_reviews_clean.csv`.

### 2. Progettazione Database SQL
- Architettura relazionale: tabelle `hotels`, `reviewers`, `reviews` e `hotel_stats`.
- Implementazione di Integrità Referenziale (Primary & Foreign Keys).
- Pipeline di caricamento automatizzata tramite SQLAlchemy.

### 3. Validazione Cross-Platform (SQL vs Pandas)
Confronto metodologico tramite l'esecuzione delle stesse query analitiche su entrambi i sistemi per garantire la coerenza del dato su:
- Trend temporali del volume di recensioni.
- Ranking geografico e distribuzione per città.
- Correlazione tra score e verbosità dei testi.

### 4. Data Visualization
Generazione di 8 grafici ad alta risoluzione finalizzati all'analisi di:
- Andamento cronologico e stagionalità.
- Distribuzione per nazionalità e variabilità degli score (Box Plots).
- Matrice di correlazione tra variabili numeriche (Heatmap).

---

## Key Insights & Conclusioni
L'analisi integrata ha permesso di evidenziare tre pillar fondamentali:

*   **Il Mercato UK:** Londra è la città più presente e i viaggiatori britannici rappresentano il **48% del contributo totale**,
*   influenzando pesantemente il sentiment globale del dataset.
  
*   **Qualità Continentale:** Nonostante i volumi inferiori, **Vienna e Barcellona** mantengono punteggi medi superiori a Londra e Parigi,
*   suggerendo un miglior rapporto qualità-prezzo percepito.
  
*   **Psicologia del Recensore:** Esiste una **correlazione inversa tra voto e lunghezza del commento**. Le recensioni negative (score 1-4) sono
*   in media l'80% più lunghe di quelle eccellenti (57 parole vs 31), confermando che l'insoddisfazione spinge a una maggiore argomentazione.

---

## 📁 Struttura della Repository
```text
PROJECT/
├── 01_EDA_CLEANING.ipynb          # Notebook: Pulizia e preprocessing

├── 02_ANALYSIS_PANDAS_PLOTS.ipynb # Notebook: Analisi e visualizzazioni

├── CREATE_TABLES.sql              # Schema DDL del database

├── INSERT_DATA.sql                # Script di popolamento

├── ANALYSIS_QUERIES.sql           # Query SQL analitiche

├── DATASET.csv                    # Dataset normalizzato

├── FINAL_REPORT.pdf               # Report completo con grafici e conclusioni estese

└── README.md                      # Documentazione di progetto
```

> **Nota:** Per una visione dettagliata di tutti i grafici e dell'analisi completa, consultare il file [FINAL_REPORT.pdf](./FINAL_REPORT.pdf).

