1. Revenue by channel
SELECT sales_channel, SUM(amount) revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY sales_channel;

2. Top 10 customers
SELECT uid, SUM(amount) total
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY uid
ORDER BY total DESC
LIMIT 10;

3. Monthly profit
WITH rev AS (
    SELECT DATE_TRUNC('month', datetime) m, SUM(amount) r
    FROM clinic_sales GROUP BY 1
),
exp AS (
    SELECT DATE_TRUNC('month', datetime) m, SUM(amount) e
    FROM expenses GROUP BY 1
)
SELECT r.m, r.r, e.e,
       (r.r - e.e) profit,
       CASE WHEN (r.r - e.e) > 0 THEN 'Profitable'
            ELSE 'Loss' END status
FROM rev r LEFT JOIN exp e ON r.m = e.m;

4. Most profitable clinic per city
WITH p AS (
    SELECT c.city, cs.cid,
           SUM(cs.amount) - COALESCE(SUM(e.amount),0) profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.city, cs.cid
),
r AS (
    SELECT *, RANK() OVER (PARTITION BY city ORDER BY profit DESC) rk FROM p
)
SELECT * FROM r WHERE rk = 1;

5. Second least profitable per state
WITH p AS (
    SELECT c.state, cs.cid,
           SUM(cs.amount) - COALESCE(SUM(e.amount),0) profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.state, cs.cid
),
r AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) rk FROM p
)
SELECT * FROM r WHERE rk = 2;
