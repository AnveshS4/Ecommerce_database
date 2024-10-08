/*
Project Description: To design and manage a database for an e-commerce platform that stores product information,customer information.
customer orders, inventory levels, and sales data. This will involve creating tables, inserting sample data, 
and running queries to derive insights about sales performance, customer behavior, and inventory status.
*/

/*
Creating the Products Table:
The Products table stores product information, including product_id, product_name, category, price, and stock_quantity. 
The product_id is an identity column, which auto-increments with each new entry.
*/
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

/*
Insert Data in to Products Table
*/
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Iphone', 'Electronics', 1000, 50),
('MacBook', 'Electronics', 850, 30),
('Airpods', 'Accessories', 350, 100),
('Speaker', 'Home Appliances', 450, 25);

Select * from Products

/*
Creating the Customers Table:
The Customers table holds customer information with fields such as customer_id, first_name, last_name, email, and address. 
The email field is unique for each customer.
*/
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255)
);
/*
Three sample customers are inserted
*/
INSERT INTO Customers (first_name, last_name, email,address) VALUES
('Revanth', 'Reddy', 'revanth@gmail.com', '12 capano dr'),
('Harsha', 'V', 'harsha@gmail.com', '201 golf dr'),
('Sushanth', 'T', 'sushanth@gmail.com', '420 North st');

Select * from Customers

/*
Creating the Orders Table:
The Orders table tracks customer orders, containing order_id, order_date, customer_id, and total_amount. A foreign key relationship with the Customers 
table ensures each order is linked to a specific customer.
*/

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    order_date DATE NOT NULL,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
/*
Three sample orders are inserted.
*/

INSERT INTO Orders (order_date, customer_id, total_amount) VALUES
('2024-09-25', 1, 1000),
('2024-09-26', 2, 850),
('2024-09-27', 3, 350);

Select * from Orders
DROP TABLE Orders;

/*
Creating the Order_Details Table:
The Order_Details table records details about each order, including order_id, product_id, quantity, and price_per_item. 
It features a computed column total_price that calculates the total cost for each product in an order.
*/

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_item DECIMAL(10, 2) NOT NULL,
    total_price AS (quantity * price_per_item),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

/*
 Sample data is added, linking products to orders.
*/
INSERT INTO Order_Details (order_id, product_id, quantity, price_per_item) VALUES
(1, 1, 1, 1000), -- Order 1: Smartphone
(1, 3, 1, 350), -- Order 1: Headphones
(2, 1, 1, 1000), -- Order 2: Smartphone
(3, 4, 1, 450);  -- Order 3: Speaker


select * from Order_Details
DROP TABLE Order_Details;

/*
Creating the Suppliers Table:
The Suppliers table contains information about suppliers, including supplier_id, supplier_name, and contact_email.
*/
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY IDENTITY(1,1) ,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE
);

/*
Two suppliers are added
*/

INSERT INTO Suppliers (supplier_name, contact_email) VALUES
('TechSupply Inc.', 'raguveer@techsupply.com'),
('HomeGoods Co.', 'info@homegoods.com');


select * from Suppliers


/*
Creating the Product_Suppliers Table:
This table establishes a many-to-many relationship between products and suppliers, using product_id and supplier_id as foreign keys.
*/

CREATE TABLE Product_Suppliers (
    product_id INT,
    supplier_id INT,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

/*
Sample relationships are inserted, showing which products are supplied by which suppliers.
*/

INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES
(1, 1), -- Smartphone from TechSupply Inc.
(2, 1), -- Laptop from TechSupply Inc.
(4, 2); -- Speaker from HomeGoods Co.

select * from Product_Suppliers


/*
This project not only demonstrates the fundamental principles of database design, including normalization and
referential integrity but also lays the groundwork for potential future enhancements. These may include advanced analytics, 
customer relationship management features, and integration with payment and shipping systems. By creating a scalable and efficient database, 
this project addresses the needs of modern e-commerce operations while providing a solid foundation for growth.
*/




																																
