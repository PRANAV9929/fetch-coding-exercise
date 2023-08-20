-- 1. What are the top 5 brands by receipts scanned for most recent month?
--  How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
-- Query for the Recent Month:
SELECT b.name AS BrandName, COUNT(r.receipts_id) AS ReceiptsScanned
FROM brands b
JOIN receipts_list rl ON b.brands_id = rl.brands_id
JOIN receipts r ON rl.receipts_id = r.receipts_id
WHERE YEAR(r.dateScanned) = YEAR(CURRENT_DATE)
  AND MONTH(r.dateScanned) = MONTH(CURRENT_DATE)
GROUP BY b.name
ORDER BY ReceiptsScanned DESC
LIMIT 5;

--2. Query for the Previous Month:
SELECT b.name AS BrandName, COUNT(r.receipts_id) AS ReceiptsScanned
FROM brands b
JOIN receipts_list rl ON b.brands_id = rl.brands_id
JOIN receipts r ON rl.receipts_id = r.receipts_id
WHERE YEAR(r.dateScanned) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
  AND MONTH(r.dateScanned) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY b.name
ORDER BY ReceiptsScanned DESC
LIMIT 5;

-- 3.When considering average spend from receipts with 'rewardsReceiptStatus’ of  ‘Accepted’ or ‘Rejected’, which is greater?

SELECT rewardsReceiptStatus, AVG(totalSpent) AS AvgSpend
FROM receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

--4. When considering total number of items purchased from receipts with  'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT rewardsReceiptStatus, SUM(purchasedItemCount) AS TotalItemsPurchased
FROM receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

--5. Which brand has the most spend among users who were created within the past  6 months?
SELECT b.name AS BrandName, SUM(rl.finalPrice) AS TotalSpend
FROM brands b
JOIN receipts_list rl ON b.brands_id = rl.brands_id
JOIN receipts r ON rl.receipts_id = r.receipts_id
JOIN users u ON r.user_id = u.user_id
WHERE u.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY TotalSpend DESC
LIMIT 1;

--6. Which brand has the most transactions among users who were created within the past 6 months?
SELECT b.name AS BrandName, COUNT(DISTINCT r.receipts_id) AS TransactionCount
FROM brands b
JOIN receipts_list rl ON b.brands_id = rl.brands_id
JOIN receipts r ON rl.receipts_id = r.receipts_id
JOIN users u ON r.user_id = u.user_id
WHERE u.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY TransactionCount DESC
LIMIT 1;
