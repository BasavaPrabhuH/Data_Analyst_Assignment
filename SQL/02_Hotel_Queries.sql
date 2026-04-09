1. Last booked room per user
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) rn
    FROM bookings
) t
WHERE rn = 1;

2. Billing in Nov 2021
SELECT b.booking_id,
       SUM(bc.item_quantity * i.item_rate) total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_TRUNC('month', b.booking_date) = '2021-11-01'
GROUP BY b.booking_id;

3. Bills > 1000 in Oct 2021
SELECT bill_id,
       SUM(item_quantity * item_rate) bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_TRUNC('month', bill_date) = '2021-10-01'
GROUP BY bill_id
HAVING SUM(item_quantity * item_rate) > 1000;

4. Most & least ordered item
WITH item_orders AS (
    SELECT DATE_TRUNC('month', bill_date) month,
           item_id,
           SUM(item_quantity) qty
    FROM booking_commercials
    WHERE EXTRACT(YEAR FROM bill_date) = 2021
    GROUP BY 1,2
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY qty DESC) r1,
           RANK() OVER (PARTITION BY month ORDER BY qty ASC) r2
    FROM item_orders
)
SELECT * FROM ranked WHERE r1 = 1 OR r2 = 1;

5. Second highest bill
WITH bills AS (
    SELECT DATE_TRUNC('month', bill_date) month,
           bill_id,
           SUM(item_quantity * item_rate) amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY 1,2
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY amount DESC) rnk
    FROM bills
)
SELECT * FROM ranked WHERE rnk = 2;
