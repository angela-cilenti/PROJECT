-- 1. Tabella HOTELS
CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name VARCHAR(255),
    hotel_address TEXT,
    lat DECIMAL(10, 8),
    lng DECIMAL(11, 8)
);

-- 2. Tabella REVIEWERS
CREATE TABLE reviewers (
    reviewer_id INT AUTO_INCREMENT PRIMARY KEY,
    reviewer_nationality VARCHAR(100)
);

-- 3. Tabella REVIEWS
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT,
    reviewer_id INT,
    review_date DATE,
    reviewer_score DECIMAL(3, 1),
    positive_review TEXT,
    negative_review TEXT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(reviewer_id)
);

-- 4. Tabella HOTEL_STATS
CREATE TABLE hotel_stats (
    hotel_id INT PRIMARY KEY,
    average_score DECIMAL(3, 1),
    total_reviews INT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);
