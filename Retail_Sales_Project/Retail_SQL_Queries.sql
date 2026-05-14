USE retail_project;

-- DROP TABLES IN CORRECT ORDER

DROP TABLE IF EXISTS returns;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- CUSTOMERS TABLE

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE,
    customer_type VARCHAR(30)
);

-- PRODUCTS TABLE

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    brand VARCHAR(50),
    product_name VARCHAR(100),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    stock_quantity INT
);

-- ORDERS TABLE

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    
    customer_id INT,
    product_id INT,

    order_date DATE,
    quantity INT,
    sales DECIMAL(10,2),
    profit DECIMAL(10,2),
    discount DECIMAL(5,2),
    payment_mode VARCHAR(30),
    region VARCHAR(50),
    delivery_status VARCHAR(30),

    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),

    CONSTRAINT fk_product
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

-- RETURNS TABLE

CREATE TABLE returns (
    return_id INT PRIMARY KEY,

    order_id INT,
    return_reason VARCHAR(100),
    return_date DATE,

    CONSTRAINT fk_order
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

INSERT INTO customers VALUES
(1,'Arun Kumar','Male',24,'Chennai','Tamil Nadu','2025-01-10','Regular'),
(2,'Priya Sharma','Female',28,'Coimbatore','Tamil Nadu','2025-02-15','Premium'),
(3,'Kavin Raj','Male',22,'Madurai','Tamil Nadu','2025-01-25','Regular'),
(4,'Divya S','Female',30,'Salem','Tamil Nadu','2025-03-01','Premium'),
(5,'Rahul Verma','Male',27,'Trichy','Tamil Nadu','2025-02-18','Regular'),
(6,'Sneha R','Female',26,'Erode','Tamil Nadu','2025-04-12','Premium'),
(7,'Vikram P','Male',31,'Tirunelveli','Tamil Nadu','2025-03-22','Regular'),
(8,'Anitha M','Female',25,'Vellore','Tamil Nadu','2025-02-08','Premium'),
(9,'Suresh B','Male',29,'Karur','Tamil Nadu','2025-01-30','Regular'),
(10,'Meena K','Female',23,'Thanjavur','Tamil Nadu','2025-04-01','Regular');

INSERT INTO products VALUES
(101,'Electronics','Laptop','Dell','Dell Inspiron',45000,55000,40),
(102,'Electronics','Mobile','Apple','iPhone 14',60000,75000,25),
(103,'Electronics','Headphones','Boat','Boat Rockerz',800,1500,100),
(104,'Furniture','Chair','Ikea','Office Chair',2000,3500,60),
(105,'Furniture','Table','Ikea','Study Table',4000,6500,35),
(106,'Clothing','Shirt','Levis','Formal Shirt',500,1200,120),
(107,'Clothing','Shoes','Nike','Running Shoes',2500,4500,70),
(108,'Electronics','Tablet','Samsung','Galaxy Tab',15000,22000,30),
(109,'Accessories','Watch','Titan','Smart Watch',3000,5500,50),
(110,'Accessories','Bag','Skybags','Travel Backpack',1200,2500,80);

INSERT INTO orders VALUES
(1001,1,101,'2026-01-05',1,55000,10000,5,'UPI','South','Delivered'),
(1002,2,102,'2026-01-08',1,75000,15000,10,'Card','South','Delivered'),
(1003,3,103,'2026-01-12',2,3000,1400,0,'Cash','South','Delivered'),
(1004,4,104,'2026-01-20',3,10500,4500,5,'UPI','South','Delivered'),
(1005,5,105,'2026-02-01',1,6500,2500,0,'Card','South','Delivered'),
(1006,6,106,'2026-02-10',4,4800,2800,15,'UPI','South','Returned'),
(1007,7,107,'2026-02-14',2,9000,4000,10,'Cash','South','Delivered'),
(1008,8,108,'2026-02-18',1,22000,7000,5,'Card','South','Delivered'),
(1009,9,109,'2026-03-01',2,11000,5000,0,'UPI','South','Delivered'),
(1010,10,110,'2026-03-05',3,7500,3900,5,'Cash','South','Delivered'),
(1011,1,102,'2026-03-10',1,75000,15000,10,'Card','South','Delivered'),
(1012,2,103,'2026-03-12',3,4500,2100,0,'UPI','South','Returned'),
(1013,3,104,'2026-03-18',2,7000,3000,5,'Cash','South','Delivered'),
(1014,4,105,'2026-04-01',1,6500,2500,0,'UPI','South','Delivered'),
(1015,5,106,'2026-04-04',5,6000,3500,10,'Card','South','Delivered'),
(1016,6,107,'2026-04-09',1,4500,2000,5,'Cash','South','Delivered'),
(1017,7,108,'2026-04-15',2,44000,14000,10,'UPI','South','Delivered'),
(1018,8,109,'2026-04-20',1,5500,2500,0,'Card','South','Returned'),
(1019,9,110,'2026-04-25',2,5000,2600,5,'Cash','South','Delivered'),
(1020,10,101,'2026-05-01',1,55000,10000,5,'UPI','South','Delivered');

INSERT INTO returns VALUES
(1,1006,'Size Issue','2026-02-15'),
(2,1012,'Damaged Product','2026-03-15'),
(3,1018,'Wrong Product','2026-04-25');

-- 1. TOTAL SALES

SELECT 
    SUM(sales) AS total_sales
FROM orders;



-- 2. TOTAL PROFIT

SELECT 
    SUM(profit) AS total_profit
FROM orders;



-- 3. TOP SELLING PRODUCTS

SELECT 
    p.product_name,
    SUM(o.sales) AS total_sales

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_sales DESC;



-- 4. CATEGORY WISE SALES

SELECT 
    p.category,
    SUM(o.sales) AS total_sales

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY total_sales DESC;



-- 5. CATEGORY WISE PROFIT

SELECT 
    p.category,
    SUM(o.profit) AS total_profit

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY total_profit DESC;



-- 6. MONTHLY SALES TRENDS

SELECT 
    MONTH(order_date) AS month_no,

    MONTHNAME(order_date) AS month_name,

    SUM(sales) AS total_sales

FROM orders

GROUP BY month_no, month_name

ORDER BY month_no;



-- 7. TOP CUSTOMERS

SELECT 
    c.customer_name,

    SUM(o.sales) AS total_sales

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.customer_name

ORDER BY total_sales DESC;



-- 8. REPEAT CUSTOMERS

SELECT 
    customer_id,

    COUNT(order_id) AS total_orders

FROM orders

GROUP BY customer_id

HAVING COUNT(order_id) > 1;



-- 9. RETURNED ORDERS

SELECT 
    o.order_id,

    p.product_name,

    r.return_reason

FROM returns r

JOIN orders o
ON r.order_id = o.order_id

JOIN products p
ON o.product_id = p.product_id;



-- 10. PROFIT MARGIN

SELECT 
    ROUND(SUM(profit) / SUM(sales) * 100, 2)
    AS profit_margin_percentage

FROM orders;



-- 11. PRODUCT RANKING

SELECT 
    p.product_name,

    SUM(o.sales) AS total_sales,

    RANK() OVER(
        ORDER BY SUM(o.sales) DESC
    ) AS product_rank

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.product_name;



-- 12. RUNNING TOTAL SALES

SELECT 
    order_date,

    sales,

    SUM(sales) OVER(
        ORDER BY order_date
    ) AS running_total_sales

FROM orders;



-- 13. REGION WISE PROFIT

SELECT 
    region,

    SUM(profit) AS total_profit

FROM orders

GROUP BY region

ORDER BY total_profit DESC;