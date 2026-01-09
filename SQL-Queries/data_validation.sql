/* ==========================================================================
   DATA VALIDATION & QUALITY ASSURANCE QUERIES
   Author: Moyo Hicks
   Purpose: Complex queries to identify data integrity issues, 
            orphaned records, and business logic violations.
   ==========================================================================
*/

-- 1. IDENTIFYING ORPHANED RECORDS (Referential Integrity Check)
-- Scenario: Finding "Items" in a game or "Transactions" that don't belong to a valid User.
-- Uses: LEFT JOIN and NULL filter.

SELECT 
    t.transaction_id, 
    t.user_id AS transaction_user_id, 
    u.id AS actual_user_id
FROM transactions t
LEFT JOIN users u ON t.user_id = u.id
WHERE u.id IS NULL;


-- 2. DETECTING DUPLICATE ACCOUNTS/RECORDS (Consistency Check)
-- Scenario: Identifying users who may have bypassed Sybil-protection by using the same IP or email.
-- Uses: GROUP BY and HAVING.

SELECT 
    email, 
    ip_address, 
    COUNT(*) as occurrence_count
FROM users
GROUP BY email, ip_address
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;


-- 3. VALIDATING CROSS-PLATFORM DATA (Unions)
-- Scenario: Comparing records between a "Staging" table and "Production" table 
-- to ensure a patch migration didn't lose data.
-- Uses: EXCEPT (or UNION ALL with a count check).

SELECT user_id, balance FROM staging_economy
EXCEPT
SELECT user_id, balance FROM production_economy;


-- 4. BUSINESS LOGIC VALIDATION (Complex Joins & Aggregation)
-- Scenario: Ensuring total user spend never exceeds their deposited balance (Fraud detection).
-- Uses: INNER JOIN, Subqueries, and Comparison Logic.

SELECT 
    u.user_id,
    u.username,
    b.total_deposited,
    s.total_spent
FROM users u
JOIN (
    SELECT user_id, SUM(amount) as total_deposited 
    FROM deposits GROUP BY user_id
) b ON u.user_id = b.user_id
JOIN (
    SELECT user_id, SUM(price) as total_spent 
    FROM purchases GROUP BY user_id
) s ON u.user_id = s.user_id
WHERE s.total_spent > b.total_deposited;


-- 5. TEMPORAL DATA VALIDATION (Boundary Testing)
-- Scenario: Finding records with "Future Dates" or impossible timestamps.
-- Uses: DATE functions.

SELECT * FROM transactions
WHERE transaction_date > CURRENT_TIMESTAMP;
