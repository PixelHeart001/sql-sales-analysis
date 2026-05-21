**Schema (MySQL v8)**

    CREATE TABLE sales (
        order_id INT,
        product VARCHAR(50),
        region VARCHAR(50),
        sales_amount INT,
        order_date DATE
    );
    
    INSERT INTO sales VALUES
    (1, 'Laptop', 'North', 50000, '2025-01-10'),
    (2, 'Mobile', 'South', 20000, '2025-01-15'),
    (3, 'Laptop', 'East', 55000, '2025-02-10'),
    (4, 'Tablet', 'West', 15000, '2025-02-18'),
    (5, 'Mobile', 'North', 25000, '2025-03-05'),
    (6, 'Laptop', 'South', 60000, '2025-03-12'),
    (7, 'Tablet', 'East', 18000, '2025-03-20'),
    (8, 'Mobile', 'West', 22000, '2025-04-01');
    
    
     CREATE TABLE customers (
        customer_id INT,
        customer_name VARCHAR(50),
        city VARCHAR(50)
    );
    
    CREATE TABLE orders (
        order_id INT,
        customer_id INT,
        product VARCHAR(50),
        region VARCHAR(50),
        sales_amount INT,
        order_date DATE
    );
    
    INSERT INTO customers VALUES
    (1, 'Rahul', 'Delhi'),
    (2, 'Neha', 'Mumbai'),
    (3, 'Amit', 'Bangalore'),
    (4, 'Priya', 'Chennai');
    
    INSERT INTO orders VALUES
    (101, 1, 'Laptop', 'North', 50000, '2025-01-10'),
    (102, 2, 'Mobile', 'South', 20000, '2025-01-15'),
    (103, 1, 'Tablet', 'North', 15000, '2025-02-10'),
    (104, 3, 'Laptop', 'East', 55000, '2025-02-18'),
    (105, 4, 'Mobile', 'West', 25000, '2025-03-05'),
    (106, 2, 'Laptop', 'South', 60000, '2025-03-12');

---

**Query #1**

    SELECT SUM(sales_amount) AS total_sale 
    FROM sales;

| total_sale |
| ---------- |
| 265000     |

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

| product | total_sales |
| ------- | ----------- |
| Laptop  | 165000      |

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

| order_id | product | region | sales_amount | order_date |
| -------- | ------- | ------ | ------------ | ---------- |
| 1        | Laptop  | North  | 50000        | 2025-01-10 |
| 3        | Laptop  | East   | 55000        | 2025-02-10 |
| 6        | Laptop  | South  | 60000        | 2025-03-12 |

---
**Query #6**

    SELECT 
        c.customer_name,
        o.product,
        o.sales_amount
    FROM orders o
    JOIN customers c
    ON o.customer_id = c.customer_id;

| customer_name | product | sales_amount |
| ------------- | ------- | ------------ |
| Rahul         | Laptop  | 50000        |
| Neha          | Mobile  | 20000        |
| Rahul         | Tablet  | 15000        |
| Amit          | Laptop  | 55000        |
| Priya         | Mobile  | 25000        |
| Neha          | Laptop  | 60000        |

---
**Query #7**

    SELECT 
        c.customer_name,
        SUM(o.sales_amount) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id 
    GROUP BY c.customer_name
    ORDER BY total_spent DESC;

| customer_name | total_spent |
| ------------- | ----------- |
| Neha          | 80000       |
| Rahul         | 65000       |
| Amit          | 55000       |
| Priya         | 25000       |

---
**Query #8**

    SELECT 
        c.customer_name,
        SUM(o.sales_amount) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
    ORDER BY total_spent DESC
    LIMIT 1;

| customer_name | total_spent |
| ------------- | ----------- |
| Neha          | 80000       |

---
**Query #9**

    SELECT 
        c.customer_name,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
    HAVING COUNT(o.order_id) > 1;

| customer_name | total_orders |
| ------------- | ------------ |
| Rahul         | 2            |
| Neha          | 2            |

---
**Query #10**

    SELECT 
        region,
        SUM(sales_amount) AS revenue
    FROM orders
    GROUP BY region;

| region | revenue |
| ------ | ------- |
| North  | 65000   |
| South  | 80000   |
| East   | 55000   |
| West   | 25000   |

---
**Query #11**

    SELECT 
        c.customer_name,
        SUM(o.sales_amount) AS total_spent,
        RANK() OVER (ORDER BY SUM(o.sales_amount) DESC) AS rank_position
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name;

| customer_name | total_spent | rank_position |
| ------------- | ----------- | ------------- |
| Neha          | 80000       | 1             |
| Rahul         | 65000       | 2             |
| Amit          | 55000       | 3             |
| Priya         | 25000       | 4             |

---
**Query #12**

    SELECT 
        order_date,
        SUM(sales_amount) AS daily_sales,
        SUM(SUM(sales_amount)) OVER (ORDER BY order_date) AS running_total
    FROM orders
    GROUP BY order_date;

| order_date | daily_sales | running_total |
| ---------- | ----------- | ------------- |
| 2025-01-10 | 50000       | 50000         |
| 2025-01-15 | 20000       | 70000         |
| 2025-02-10 | 15000       | 85000         |
| 2025-02-18 | 55000       | 140000        |
| 2025-03-05 | 25000       | 165000        |
| 2025-03-12 | 60000       | 225000        |

---
**Query #13**

    SELECT customer_name
    FROM customers
    WHERE customer_id IN (
        SELECT customer_id
        FROM orders
        GROUP BY customer_id
        HAVING SUM(sales_amount) > (
            SELECT AVG(sales_amount) FROM orders
        )
    );

| customer_name |
| ------------- |
| Rahul         |
| Neha          |
| Amit          |

---
**Query #14**

    SELECT MAX(sales_amount) AS second_highest
    FROM orders
    WHERE sales_amount < (
        SELECT MAX(sales_amount) FROM orders
    );

| second_highest |
| -------------- |
| 55000          |

---
**Query #15**

    SELECT region, SUM(sales_amount) AS revenue
    FROM orders
    GROUP BY region
    ORDER BY revenue DESC
    LIMIT 1;

| region | revenue |
| ------ | ------- |
| South  | 80000   |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/oraEKGve5vhtyGpGnw3eGs/5)
