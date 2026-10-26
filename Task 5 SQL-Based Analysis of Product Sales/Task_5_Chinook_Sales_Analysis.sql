/*
  Task 5: SQL-Based Analysis of Product Sales
 Database: Chinook_Sqlite.sqlite (SQLite)
 Run this script against the Chinook database in DB Browser for SQLite,
 SQLiteStudio, or another SQLite client.

 Dataset note:
 Chinook has BillingCountry, but no Region column. The geographic result
 below is therefore reported by billing country; no countries are assigned
 to invented regions.
 Product note:
 Track is the product-level table, so top-selling products are tracks.
 Sales revenue is calculated from invoice lines as UnitPrice * Quantity.
*/
-------------------------------------------------------------------------------
 /*
 1. Top-selling products (tracks)
 Rank products by units purchased; break ties by revenue and product name
 so the result contains exactly 10 products. ROW_NUMBER() is the optional
 window-function bonus.
 */
-------------------------------------------------------------------------------
WITH track_sales AS (
    SELECT
        t.TrackId,
        t.Name AS Product,
        SUM(il.Quantity) AS UnitsSold,
        ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS Revenue
    FROM InvoiceLine AS il
    INNER JOIN Track AS t
        ON t.TrackId = il.TrackId
    GROUP BY
        t.TrackId,
        t.Name
),
ranked_tracks AS (
    SELECT
        TrackId,
        Product,
        UnitsSold,
        Revenue,
        ROW_NUMBER() OVER (
            ORDER BY UnitsSold DESC, Revenue DESC, Product
        ) AS SalesRank
    FROM track_sales
)
SELECT
    SalesRank,
    Product,
    UnitsSold,
    Revenue
FROM ranked_tracks
WHERE SalesRank <= 10
ORDER BY SalesRank, Product;

-------------------------------------------------------------------------------
-- 2. Revenue by region
-- Chinook has BillingCountry rather than a Region field. For this analysis,
-- countries are grouped into continent-level regions using the CASE mapping
-- below. Revenue comes from Invoice so each invoice is counted only once.
-------------------------------------------------------------------------------
SELECT
    CASE
        WHEN BillingCountry IN ('USA', 'Canada') THEN 'North America'
        WHEN BillingCountry IN ('Brazil', 'Argentina', 'Chile') THEN 'South America'
        WHEN BillingCountry = 'India' THEN 'Asia'
        WHEN BillingCountry = 'Australia' THEN 'Oceania'
        WHEN BillingCountry IN (
            'Austria', 'Belgium', 'Czech Republic', 'Denmark', 'Finland',
            'France', 'Germany', 'Hungary', 'Ireland', 'Italy', 'Netherlands',
            'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'United Kingdom'
        ) THEN 'Europe'
        ELSE 'Other'
    END AS Region,
    COUNT(DISTINCT BillingCountry) AS Countries,
    COUNT(*) AS InvoiceCount,
    ROUND(SUM(Total), 2) AS Revenue
FROM Invoice
GROUP BY Region
ORDER BY Revenue DESC;

-------------------------------------------------------------------------------
-- 3. Monthly performance
-- Summarize revenue and invoices from Invoice, and units sold from
-- InvoiceLine. Aggregate each table by month before joining so invoice totals
-- are not multiplied by the number of invoice lines.
-- LAG() shows month-over-month changes (the first month has no prior month).
-------------------------------------------------------------------------------
WITH monthly_invoices AS (
    SELECT
        strftime('%Y-%m', InvoiceDate) AS SalesMonth,
        COUNT(*) AS InvoiceCount,
        SUM(Total) AS Revenue
    FROM Invoice
    GROUP BY strftime('%Y-%m', InvoiceDate)
),
monthly_units AS (
    SELECT
        strftime('%Y-%m', i.InvoiceDate) AS SalesMonth,
        SUM(il.Quantity) AS UnitsSold
    FROM Invoice AS i
    INNER JOIN InvoiceLine AS il
        ON il.InvoiceId = i.InvoiceId
    GROUP BY strftime('%Y-%m', i.InvoiceDate)
),
monthly_performance AS (
    SELECT
        mi.SalesMonth,
        mi.InvoiceCount,
        ROUND(mi.Revenue, 2) AS Revenue,
        mu.UnitsSold
    FROM monthly_invoices AS mi
    INNER JOIN monthly_units AS mu
        ON mu.SalesMonth = mi.SalesMonth
)
SELECT
    SalesMonth,
    InvoiceCount,
    Revenue,
    UnitsSold,
    ROUND(Revenue - LAG(Revenue) OVER (ORDER BY SalesMonth), 2) AS RevenueChange,
    ROUND(100.0 * (Revenue - LAG(Revenue) OVER (ORDER BY SalesMonth)) /
          NULLIF(LAG(Revenue) OVER (ORDER BY SalesMonth), 0), 2) AS RevenueChangePct,
    UnitsSold - LAG(UnitsSold) OVER (ORDER BY SalesMonth) AS UnitsChange
FROM monthly_performance
ORDER BY SalesMonth;







