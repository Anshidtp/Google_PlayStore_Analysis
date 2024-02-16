-- Identifying NULL Values --

SELECT * FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL;

--Removing NULL values from the Dataset--
DELETE FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL;

-- overview of dataset --
SELECT
COUNT(DISTINCT App) AS Total_apps,
COUNT(DISTINCT Category) AS Total_categories
FROM dbo.googleplaystore

--Explore App category --
SELECT 
Category,
COUNT(App) as Total_app
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY Total_app DESC

--Explore TOP 5 App category --
SELECT TOP 5 
Category,
COUNT(App) as Total_app
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY Total_app DESC;

-- TOP Rated Free apps--
SELECT TOP 10
App,
Category,
Rating,
Reviews
FROM dbo.googleplaystore
WHERE Type ='Free' AND Rating <> 'NaN'
ORDER BY Rating DESC;

--Most Reviewed App --
SELECT TOP 10
Category,
App,
Reviews
FROM dbo.googleplaystore
ORDER BY Reviews DESC;

--Average Rating By Category --
SELECT
Category,
AVG(TRY_CAST(Rating AS FLOAT)) AS Avg_Rating 
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY Avg_Rating DESC;

--TOP categories by No of Install --
SELECT 
Category,
SUM(CAST(REPLACE(SUBSTRING(Installs,1, PATINDEX('%[^0-9]%', Installs + ' ') -1),',',' ')AS INT)) as total_installs
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY total_installs DESC;

--Average sentiment polarity by App Category-- 
SELECT 
Category,
AVG(TRY_CAST(Sentiment_Polarity AS FLOAT)) AS SENTIMENT
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
GROUP BY Category
ORDER BY SENTIMENT DESC;

--Sentiment Reviews By app_category--
SELECT 
Category,
Sentiment,
COUNT(*) AS TOTAL_SENTIMENT
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
WHERE Sentiment <> 'nan'
GROUP BY Category,Sentiment
ORDER BY TOTAL_SENTIMENT DESC;




