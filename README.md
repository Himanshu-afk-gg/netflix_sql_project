# Netflix Movies and TV shows Data Analysis using SQL

![Netflix Logo](https://github.com/Himanshu-afk-gg/netflix_sql_project/blob/main/Netflix%20logo.png)


# Netflix Content Analysis

## Overview
This project involves analyzing Netflix's TV shows and movies to uncover insights and solve business-related problems using SQL. The dataset contains detailed information about Netflix's content library, including metadata such as titles, directors, casts, countries, release years, ratings, and more. By writing and executing SQL queries, the analysis aims to provide useful insights for decision-making.

## Objective
The main objective of this analysis is to answer several business-related questions, including:
- How many movies vs. TV shows are on Netflix?
- What is the most common rating?
- Which movies were released in specific years (e.g., 2020)?
- Which countries have the most content on Netflix?
- What is the longest movie?
- What content has been added in the last two years?
- What content has specific directors or has a certain number of seasons?
- How many content items are in each genre?

## Schema
The table `netflix` is structured as follows:

```sql

CREATE TABLE netflix(
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(208),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(105),
    description VARCHAR(250)
);

```

## Solutions
Here are the SQL queries used to answer each business problem:


### 1. Count the number of movies vs TV shows
```sql

SELECT type, COUNT(type) as total_content
FROM netflix
GROUP BY type;

```

### 2. Find the most common rating for movies and TV shows
```sql
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

```

### 3. List all movies released in a specific year (e.g. 2020)
```sql
SELECT
title as Movies_released_in_2020
FROM netflix
WHERE type = 'Movie' AND release_year = 2020;

```

### 4. Find the top 5 countries with the most content on Netflix
```sql
SELECT
	UNNEST(STRING_TO_ARRAY(country, ',')) as distinct_country,
	COUNT(show_id)
	FROM netflix
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;


```

### 5. Identify the longest Movie
```sql
SELECT
	title,
	type,
	CAST(REPLACE(duration,'min','') AS INT) AS minutes
	FROM netflix
		WHERE type = 'Movie'
		ORDER BY minutes desc;

```

### 6. Find content added in the last 2 years
```sql
SELECT *
FROM netflix
WHERE TO_DATE(DATE_ADDED, 'MONTH DD, YYYY') >= CURRENT_DATE - INTERVAL '2 years'

```

### 7. Find all movies/tv shows by the director 'Rajiv Chilaka'
```sql
SELECT
*
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

```

### 8. List all TV shows with more than 5 seasons
```sql
SELECT
*
FROM netflix
WHERE type = 'TV Show'
AND
SPLIT_PART(duration, ' ', 1)::numeric > 5;

```

### 9. Count the number of content items in each genre
```sql
SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) as distinct_genre,
COUNT(listed_in) as total_count
FROM netflix
GROUP BY distinct_genre
ORDER BY total_count desc;

```

### 10. Find each years number of content released/added in india on netflix. return top 5 year with the highest content release/added
```sql
SELECT 
EXTRACT(YEAR FROM TO_DATE(date_added, 'MONTH DD, YYYY')) AS year,
COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

```

## Findings and Suggestions

### Key Findings:
1. **Movies vs. TV Shows**: Netflix hosts more movies than TV shows, showing that the platform primarily caters to film viewers.
2. **Most Common Rating**: Specific ratings are prevalent across movies and TV shows, helping to target certain audience segments.
3. **Top Countries**: The United States dominates the content, but other countries are also well represented.
4. **Recent Content Additions**: There is a steady stream of new content, which keeps the platform engaging for subscribers.
5. **Longest Movie**: Identifying the longest movie helps understand Netflix's approach to epic, long-format content.
6. **Director-Specific Content**: Netflix includes a variety of directors, including specialized content like that of 'Rajiv Chilaka'.
7. **Genre Breakdown**: Understanding the genre distribution helps to identify trends in audience preferences.

### Suggestions:
- **Targeted Recommendations**: Leverage the most common ratings and genres to better recommend content to users.
- **International Expansion**: Continue to add more content from top countries and emerging markets.
- **Long-form Content Marketing**: Highlight longer movies or TV shows for binge-watching audiences.
- **Content Updates**: Focus on promoting newly added content, particularly from the last two years.

## Stay Connected
If you'd like to stay connected and follow more of my work, feel free to visit my [LinkedIn profile](https://www.linkedin.com/in/himanshu-jaiswal-a9a30222a/). I’d love to network and discuss data analytics, SQL, or Netflix-related projects.

## Thank You
Thank you for visiting and taking the time to explore this repository! Your interest is much appreciated.


## How to Use
To run the analysis, use the provided SQL queries with the Netflix dataset. Each query is designed to answer a specific business question.
