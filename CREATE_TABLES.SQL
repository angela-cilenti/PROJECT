
-- 1. Tabella HOTELS: contiene le anagrafiche univoche degli hotel
CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    hotel_address VARCHAR(500) NOT NULL,
    lat DECIMAL(10, 8),
    lng DECIMAL(11, 8)
);

-- 2. Tabella REVIEWERS: contiene le nazionalità univoche dei recensori
CREATE TABLE reviewers (
    reviewer_id INT AUTO_INCREMENT PRIMARY KEY,
    reviewer_nationality VARCHAR(100) NOT NULL
);

-- 3. Tabella HOTEL_STATS: statistiche aggregate per hotel 
CREATE TABLE hotel_stats (
    hotel_id INT PRIMARY KEY,
    average_score DECIMAL(3, 1),
    total_reviews BIGINT(20),
    additional_number_of_scoring BIGINT(20),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id) ON DELETE CASCADE
);

-- 4. Tabella REVIEWS: contiene le singole recensioni collegate a hotel e recensore
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    review_date DATE,
    reviewer_score DECIMAL(3, 1),
    negative_review TEXT,
    positive_review TEXT,
    review_total_negative_word_counts INT,
    review_total_positive_word_counts INT,
    total_reviews_reviewer_has_given INT,
    days_since_review VARCHAR(50),
    tags VARCHAR(500),
    review_year INT,
    review_month INT,
    days_since_numeric INT,
    total_review_length INT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(reviewer_id) ON DELETE CASCADE
);
