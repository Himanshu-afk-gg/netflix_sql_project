-- NETFLIX PROJECT


CREATE TABLE netflix(
	show_id	VARCHAR(6),
	type	VARCHAR(10),
	title	VARCHAR(150),
	director	VARCHAR(208),
	casts	VARCHAR(1000),
	country	VARCHAR(150),
	date_added	VARCHAR(50),
	release_year	INT,
	rating	VARCHAR(10),
	duration	VARCHAR(15),
	listed_in	VARCHAR(105),
	description VARCHAR(250)
);





SELECT * FROM netflix;

SELECT COUNT(*) FROM netflix;

SELECT DISTINCT type FROM netflix;














-- 15 NETFLIX BUSINESS STATS

-- 1. Count the number of movies vs TVshows

SELECT
type,
COUNT(type) as total_content
FROM netflix
GROUP BY type;


-- 2. Find the most common rating for movies and TVshows

WITH temp_table AS(SELECT
type,
MAX(rating) as rating_name,
COUNT(rating) as total_rating,
RANK() OVER(PARTITION BY type ORDER BY COUNT(rating) DESC) as ranking
FROM netflix
GROUP BY type, rating
)

SELECT type,rating_name
FROM temp_table
WHERE ranking = 1;



-- 3. List all movies released in a specific year (e.g. 2020)

SELECT
title as Movies_released_in_2020
FROM netflix
WHERE type = 'Movie' AND release_year = 2020;



-- 4. Find the top 5 countries with the most content on Netflix

SELECT
	UNNEST(STRING_TO_ARRAY(country, ',')) as distinct_country,
	COUNT(show_id)
	FROM netflix
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;



-- 5. Identify the longest Movie

SELECT
	title,
	type,
	CAST(REPLACE(duration,'min','') AS INT) AS minutes
	FROM netflix
		WHERE type = 'Movie'
		ORDER BY minutes desc;
		
		
		
-- 6. Find content added in the last 2 years

SELECT *
FROM netflix
WHERE TO_DATE(DATE_ADDED, 'MONTH DD, YYYY') >= CURRENT_DATE - INTERVAL '2 years'



-- 7. Find all movies/tvshows by the director 'Rajiv Chilaka'

SELECT
*
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';



-- 8. List all tvshows with more than 5 seasons

SELECT
*
FROM netflix
WHERE type = 'TV Show'
AND
SPLIT_PART(duration, ' ', 1)::numeric > 5;



-- 9. Count the number of content items in each genre

SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) as distinct_genre,
COUNT(listed_in) as total_count
FROM netflix
GROUP BY distinct_genre
ORDER BY total_count desc;



-- 10. Find each years number of content released/added in india on netflix.
--     return top 5 year with the highest content release/added

SELECT 
EXTRACT(YEAR FROM TO_DATE(date_added, 'MONTH DD, YYYY')) AS year,
COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

