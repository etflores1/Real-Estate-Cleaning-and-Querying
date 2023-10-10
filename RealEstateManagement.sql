-- Table we are working with -- 
SELECT *
FROM [US Real Estate].dbo.[realtor-data]



-- Remove unused columns populated with null values --
ALTER TABLE [US Real Estate].dbo.[realtor-data]
DROP COLUMN prev_sold_date



-- Remove all rows with null values --
DELETE FROM [US Real Estate].dbo.[realtor-data]
WHERE [bed] IS NULL OR
[bath] IS NULL OR
[acre_lot] IS NULL OR
[zip_code] IS NULL OR
[house_size] IS NULL OR
[price] IS NULL;



-- Convert acre_lot to 2 decimal places
UPDATE [US Real Estate].dbo.[realtor-data] 
SET acre_lot = ROUND(acre_lot, 2)



-- Find out which state has the most listings --
SELECT state, COUNT(bed) as number_of_listing
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY state
ORDER BY 2 desc;



-- Shows average house price for each state --
SELECT state, ROUND(AVG(price),0) as avg_price
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY state
ORDER BY avg_price desc;



-- Shows average price for number of beds and baths -- 
SELECT bed, ROUND(AVG(price),0) as avg_price
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY bed
ORDER by bed desc;

SELECT bath, ROUND(AVG(price),0) as avg_price
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY bath
ORDER by bath desc;



-- Find top 10 most cities with the highest average housing price --
SELECT city, ROUND(AVG(price),0) as avg_price
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY city
ORDER BY avg_price desc
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;


-- Create view for each city and their averages --
CREATE VIEW city_averages AS
SELECT city, ROUND(AVG(price),0) as avg_price, ROUND(AVG(house_size),0) as avg_size, ROUND(AVG(acre_lot),0) as avg_acre_lot
FROM [US Real Estate].dbo.[realtor-data]
GROUP BY city;

