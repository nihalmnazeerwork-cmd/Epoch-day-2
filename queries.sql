-- Epochs '26 - Assignment 2: Northwind Database SQL Analysis
-- Database: dist/northwind.db (https://github.com/jpwhite3/northwind-SQLite3)

-- Q1: Top 10 Selling Products (by quantity sold)
SELECT p.ProductName,SUM(od.Quantity)AS TotalQuantitySold
FROM "Order Details" od
JOIN Products p ON od.ProductID=p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC
LIMIT 10;


-- Q2: Top 10 Customers by Revenue
SELECT c.CompanyName,ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS Revenue
FROM "Order Details" od
JOIN Orders o ON od.OrderID=o.OrderID
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY c.CompanyName
ORDER BY Revenue DESC
LIMIT 10;


-- Q3: Monthly Sales Trends
SELECT strftime('%Y-%m',o.OrderDate)AS Month,
       ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2)AS MonthlyRevenue
FROM Orders o
JOIN "Order Details" od ON o.OrderID=od.OrderID
GROUP BY Month
ORDER BY Month;


-- Q4: Best-Performing Product Categories
SELECT cat.CategoryName, ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS Revenue
FROM "Order Details" od
JOIN Products p ON od.ProductID=p.ProductID
JOIN Categories cat ON p.CategoryID=cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC;


-- Q5: Customer Purchase Frequency (Top 10 by number of orders)
SELECT c.CompanyName,COUNT(o.OrderID)AS NumberOfOrders
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
GROUP BY c.CompanyName
ORDER BY NumberOfOrders DESC
LIMIT 10;
