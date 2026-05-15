-- create
-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



-- =========================
-- INSERT CUSTOMERS
-- =========================

INSERT INTO customers VALUES
(1,'Rahul Sharma','Delhi','2024-01-15'),
(2,'Anjali Mehta','Mumbai','2024-02-10'),
(3,'Arun Kumar','Chennai','2024-03-05'),
(4,'Sneha Reddy','Bangalore','2024-03-18'),
(5,'Vikram Singh','Hyderabad','2024-04-01'),
(6,'Priya Nair','Kochi','2024-04-12'),
(7,'Rohit Verma','Pune','2024-05-08'),
(8,'Neha Kapoor','Delhi','2024-05-20');



-- =========================
-- INSERT PRODUCTS
-- =========================

INSERT INTO products VALUES
(101,'Laptop','Electronics',60000),
(102,'Smartphone','Electronics',35000),
(103,'Headphones','Electronics',2500),
(104,'Shoes','Fashion',3000),
(105,'Watch','Fashion',7000),
(106,'Backpack','Accessories',1800),
(107,'Keyboard','Electronics',2200),
(108,'T-Shirt','Fashion',1200),
(109,'Gaming Mouse','Electronics',1500),
(110,'Sunglasses','Accessories',2500);



-- =========================
-- INSERT ORDERS
-- =========================

INSERT INTO orders VALUES
(1001,1,'2025-01-05'),
(1002,2,'2025-01-07'),
(1003,3,'2025-01-10'),
(1004,1,'2025-01-12'),
(1005,4,'2025-01-15'),
(1006,5,'2025-01-18'),
(1007,6,'2025-01-20'),
(1008,2,'2025-01-22'),
(1009,7,'2025-01-25'),
(1010,8,'2025-01-28'),
(1011,3,'2025-02-02'),
(1012,4,'2025-02-05');



-- =========================
-- INSERT ORDER ITEMS
-- =========================

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,103,2),

(3,1002,102,1),
(4,1002,109,1),

(5,1003,104,2),

(6,1004,105,1),
(7,1004,106,2),

(8,1005,101,1),
(9,1005,107,1),

(10,1006,108,3),

(11,1007,102,1),
(12,1007,110,1),

(13,1008,103,2),
(14,1008,104,1),

(15,1009,101,1),

(16,1010,105,2),

(17,1011,109,3),
(18,1011,103,1),

(19,1012,106,2),
(20,1012,108,2);


SELECT 
    p.product_name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;


SELECT 
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.price * oi.quantity) AS monthly_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;