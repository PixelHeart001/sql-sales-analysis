**Schema (MySQL v8)**

    CREATE TABLE sales (
        order_id INT,
        product VARCHAR(50),
        region VARCHAR(50),
        sales_amount INT,
        order_date DATE
    );
    
    INSERT INTO sales VALUES
    (1, 'Laptop A', 'North', 50000, '2025-01-10'),
    (2, 'Mobile A', 'South', 20000, '2025-01-15'),
    (3, 'Laptop B', 'East', 55000, '2025-02-10'),
    (4, 'Tablet A', 'West', 15000, '2025-02-18'),
    (5, 'Mobile B', 'North', 25000, '2025-03-05'),
    (6, 'Laptop C', 'South', 60000, '2025-03-12'),
    (7, 'Tablet B', 'East', 18000, '2025-03-20'),
    (8, 'Mobile C', 'West', 22000, '2025-04-01');

---

**Query #1**

    SELECT SUM(sales_amount) AS total_sales FROM sales;

| total_sales |
| ----------- |
| 265000      |

---
**Query #2**

    SELECT region, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY region;

| region | total_sales |
| ------ | ----------- |
| North  | 75000       |
| South  | 80000       |
| East   | 73000       |
| West   | 37000       |

---
**Query #3**

    SELECT product, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY product
    ORDER BY total_sales DESC
    LIMIT 1;

| product  | total_sales |
| -------- | ----------- |
| Laptop C | 60000       |

---
**Query #4**

    SELECT 
        MONTH(order_date) AS month,
        SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY month
    ORDER BY month;

| month | total_sales |
| ----- | ----------- |
| 1     | 70000       |
| 2     | 70000       |
| 3     | 103000      |
| 4     | 22000       |

---
**Query #5**

    SELECT *
    FROM sales
    WHERE sales_amount > 30000;

| order_id | product  | region | sales_amount | order_date |
| -------- | -------- | ------ | ------------ | ---------- |
| 1        | Laptop A | North  | 50000        | 2025-01-10 |
| 3        | Laptop B | East   | 55000        | 2025-02-10 |
| 6        | Laptop C | South  | 60000        | 2025-03-12 |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/cUhcKEjiBjFzbpDpZcaPXD/0)
