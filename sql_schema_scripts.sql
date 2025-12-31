CREATE DATABASE IF NOT EXISTS traffic_project;

USE traffic_project;

CREATE TABLE website_traffic_data (
    title VARCHAR(250),
    keyword VARCHAR(250),
    keyword_ID INT,
    positions INT,
    previous_positions INT,
    last_seen DATE,
    Search_Volume INT,
    CPC DECIMAL(10,2),
    Traffic INT,
    Traffic_Percent DECIMAL(10,2),
    Traffic_Cost INT,
    Traffic_Cost_Percent DECIMAL(10,2),
    Competition DECIMAL(10,2),
    Number_of_Results INT,
    Keyword_difficulty INT
);

CREATE TABLE keyword (
    keyword_ID INT PRIMARY KEY,
    keyword VARCHAR(250)
);

CREATE TABLE keyword_difficulty (
    keyword_ID INT PRIMARY KEY,
    Keyword_difficulty INT
);

CREATE TABLE search_volume (
    keyword_ID INT PRIMARY KEY,
    Search_Volume INT
);

ALTER TABLE keyword_difficulty
ADD COLUMN difficulty_level VARCHAR(50);

SELECT * FROM keyword;
SELECT * FROM keyword_difficulty;
SELECT * FROM search_volume;
SELECT * FROM website_traffic_data;

ALTER TABLE website_traffic_data
ADD FOREIGN KEY (keyword_ID) REFERENCES keyword(keyword_ID);






