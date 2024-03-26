Create database MySQL_Project;

CREATE TABLE Suppliers (
    SupplierID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ContactName VARCHAR(100),
    Email VARCHAR(100));

CREATE TABLE Products (
    ProductID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Category VARCHAR(100),
    Price DECIMAL(10, 2),
    SupplierID VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID));

CREATE TABLE ProductVariations (
    ProductID VARCHAR(20),
    Size VARCHAR(50),
    Color VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

CREATE TABLE Warehouses (
    WarehouseID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255));

CREATE TABLE Inventory (
    InventoryID VARCHAR(20) PRIMARY KEY,
    ProductID VARCHAR(20),
    WarehouseID VARCHAR(20),
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID));

CREATE TABLE StockMovements (
    MovementID VARCHAR(20) PRIMARY KEY,
    ProductID VARCHAR(20),
    WarehouseID VARCHAR(20),
    MovementType ENUM('Purchase', 'Sale', 'Return', 'Adjustment'),
    Quantity INT,
    MovementDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID));

CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(100));

CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    CustomerID VARCHAR(20),
    ProductID VARCHAR(20),
    Quantity INT,
    Price DECIMAL(10, 2),
    OrderDate DATETIME,
    Status ENUM('Pending', 'Processing', 'Shipped', 'Delivered'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

CREATE TABLE PurchaseOrders (
    OrderID VARCHAR(20) PRIMARY KEY,
    SupplierID VARCHAR(20),
    OrderDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    Status ENUM('Pending', 'Sent', 'Received', 'Completed'),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID));

CREATE TABLE Deliveries (
    DeliveryID VARCHAR(20) PRIMARY KEY,
    OrderID VARCHAR(20),
    DeliveryDate DATETIME,
    TotalQuantity INT,
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrders(OrderID));

CREATE TABLE SuppliersPayments (
    PaymentID VARCHAR(20) PRIMARY KEY,
    SupplierID VARCHAR(20),
    Amount DECIMAL(10, 2),
    PaymentDate DATETIME,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID));
    
-- 	Suppliers    
INSERT INTO Suppliers (SupplierID, Name, ContactName, Email) VALUES
('SU-ID-12345', 'AutoParts Express', 'John Smith', 'john@example.com'),
('SU-ID-54321', 'Car Components Inc.', 'Emily Johnson', 'emily@example.com'),
('SU-ID-98765', 'Vehicle Parts Warehouse', 'Michael Brown', 'michael@example.com'),
('SU-ID-24680', 'Speedy Auto Supplies', 'Jessica Davis', 'jessica@example.com'),
('SU-ID-13579', 'Automotive Parts Direct', 'David Wilson', 'david@example.com');

-- Products
INSERT INTO Products (ProductID, Name, Description, Category, Price, SupplierID) VALUES
('EO-RT600', 'Engine Oil RT600', 'High-performance engine oil suitable for various vehicles.', 'Oil', 25.99, 'SU-ID-12345'),
('TB-GEN123', 'Timing Belt GEN123', 'Timing belt for precise engine timing.', 'Belt', 35.50, 'SU-ID-54321'),
('BRKPD-BD456', 'Brake Pads BD456', 'Quality brake pads designed for smooth braking.', 'Brakes', 45.75, 'SU-ID-98765'),
('SPRKPLG-AP789', 'Spark Plug AP789', 'Premium spark plugs for efficient combustion.', 'Ignition', 12.99, 'SU-ID-24680'),
('AF-CA345', 'Air Filter CA345', 'High-flow air filter for improved engine performance.', 'Filter', 19.99, 'SU-ID-13579'),
('STRTMTR-MS450', 'Starter Motor MS450', 'Reliable starter motor for easy engine starting.', 'Electrical', 75.25, 'SU-ID-12345'),
('ALTR-EX550', 'Alternator EX550', 'Efficient alternator for reliable electrical power.', 'Electrical', 95.50, 'SU-ID-54321'),
('FTBLT-BT678', 'Fan Belt BT678', 'Durable fan belt for engine cooling.', 'Belt', 22.75, 'SU-ID-98765'),
('WPRBLD-RC333', 'Wiper Blade RC333', 'High-quality wiper blades for clear visibility.', 'Wipers', 15.99, 'SU-ID-24680'),
('RSNTR-BR444', 'Radiator BR444', 'Efficient radiator for engine cooling.', 'Cooling', 85.99, 'SU-ID-13579'),
('FLFLD-TL777', 'Fuel Filter TL777', 'Fuel filter for clean fuel supply to the engine.', 'Filter', 14.50, 'SU-ID-12345'),
('STRGNR-PP888', 'Steering Gear PP888', 'Responsive steering gear for precise handling.', 'Steering', 120.75, 'SU-ID-54321'),
('CRCON-CC999', 'Carburetor Cone CC999', 'High-performance carburetor cone for fuel delivery.', 'Fuel System', 55.99, 'SU-ID-98765'),
('THRMST-TM222', 'Thermostat TM222', 'Thermostat for regulating engine temperature.', 'Cooling', 18.50, 'SU-ID-24680'),
('ENGFLD-EF111', 'Engine Fluid EF111', 'Multi-purpose engine fluid for various applications.', 'Fluid', 29.99, 'SU-ID-13579');

-- ProductVariations
INSERT INTO ProductVariations (ProductID, Size, Color, Quantity) VALUES
('EO-RT600', 'N/A', 'N/A', 100),
('TB-GEN123', 'Standard', 'Black', 50),
('BRKPD-BD456', 'Standard', 'N/A', 75),
('SPRKPLG-AP789', 'N/A', 'Silver', 200),
('AF-CA345', 'Standard', 'White', 150),
('STRTMTR-MS450', 'N/A', 'N/A', 30),
('ALTR-EX550', 'N/A', 'N/A', 40),
('FTBLT-BT678', 'Standard', 'Black', 60),
('WPRBLD-RC333', 'Standard', 'Black', 80),
('RSNTR-BR444', 'N/A', 'N/A', 25);

-- Warehouses
INSERT INTO Warehouses (WarehouseID, Name, Location) VALUES
('NW-US-100TX', 'North Warehouse', 'Texas'),
('SW-US-200CA', 'South Warehouse', 'California'),
('EW-US-300NY', 'East Warehouse', 'New York'),
('WW-US-400FL', 'West Warehouse', 'Florida'),
('CW-US-500IL', 'Central Warehouse', 'Illinois');

-- Inventory
INSERT INTO Inventory (InventoryID, ProductID, WarehouseID, Quantity) VALUES
('IN-EO-TX', 'EO-RT600', 'NW-US-100TX', 50),
('IN-TB-CA', 'TB-GEN123', 'SW-US-200CA', 30),
('IN-BRKPD-TX', 'BRKPD-BD456', 'NW-US-100TX', 25),
('IN-SPRKPLG-NY', 'SPRKPLG-AP789', 'EW-US-300NY', 100),
('IN-AF-FL', 'AF-CA345', 'WW-US-400FL', 70),
('IN-STRTMTR-TX', 'STRTMTR-MS450', 'NW-US-100TX', 15),
('IN-ALTR-NY', 'ALTR-EX550', 'EW-US-300NY', 20),
('IN-FTBLT-IL', 'FTBLT-BT678', 'CW-US-500IL', 40),
('IN-WPRBLD-FL', 'WPRBLD-RC333', 'WW-US-400FL', 60),
('IN-RSNTR-CA', 'RSNTR-BR444', 'SW-US-200CA', 35),
('IN-FLFLD-NY', 'FLFLD-TL777', 'EW-US-300NY', 45),
('IN-STRGNR-TX', 'STRGNR-PP888', 'NW-US-100TX', 10),
('IN-CRCON-IL', 'CRCON-CC999', 'CW-US-500IL', 55),
('IN-THRMST-CA', 'THRMST-TM222', 'SW-US-200CA', 25),
('IN-ENGFLD-TX', 'ENGFLD-EF111', 'NW-US-100TX', 80),
('IN-EO-CA', 'EO-RT600', 'SW-US-200CA', 70),
('IN-TB-FL', 'TB-GEN123', 'WW-US-400FL', 20),
('IN-BRKPD-NY', 'BRKPD-BD456', 'EW-US-300NY', 45),
('IN-SPRKPLG-TX', 'SPRKPLG-AP789', 'NW-US-100TX', 120),
('IN-AF-CA', 'AF-CA345', 'SW-US-200CA', 90);

-- StockMovements
INSERT INTO StockMovements (MovementID, ProductID, WarehouseID, MovementType, Quantity, MovementDate) VALUES
('MV00-AP', 'EO-RT600', 'NW-US-100TX', 'Purchase', 20, '2022-04-15 08:00:00'),
('MV01-TU', 'TB-GEN123', 'SW-US-200CA', 'Sale', 15, '2022-06-22 10:30:00'),
('MV02-SP', 'BRKPD-BD456', 'NW-US-100TX', 'Return', 30, '2022-08-10 13:45:00'),
('MV03-AP', 'SPRKPLG-AP789', 'EW-US-300NY', 'Purchase', 25, '2022-10-05 16:20:00'),
('MV04-TU', 'AF-CA345', 'WW-US-400FL', 'Sale', 10, '2022-11-17 09:15:00'),
('MV05-SP', 'STRTMTR-MS450', 'NW-US-100TX', 'Purchase', 40, '2023-01-20 11:30:00'),
('MV06-AP', 'ALTR-EX550', 'EW-US-300NY', 'Return', 35, '2023-03-08 14:50:00'),
('MV07-TU', 'WPRBLD-RC333', 'WW-US-400FL', 'Sale', 20, '2023-05-12 10:00:00'),
('MV08-SP', 'RSNTR-BR444', 'SW-US-200CA', 'Purchase', 45, '2023-07-28 12:45:00'),
('MV09-AP', 'FLFLD-TL777', 'EW-US-300NY', 'Return', 50, '2023-09-14 08:30:00');

-- Customers
INSERT INTO Customers (CustomerID, Name, Email) VALUES
('CUS-12345', 'Auto Parts Emporium', 'info@autopartsemporium.com'),
('CUS-54321', 'Car Enthusiast Garage', 'contact@car_enthusiast.com'),
('CUS-98765', 'Vehicle Repair Solutions', 'support@vehiclerepairsolutions.com');

-- Orders
INSERT INTO Orders (OrderID, CustomerID, ProductID, Quantity, Price, OrderDate, Status) VALUES
('OD-ID-123456', 'CUS-12345', 'EO-RT600', 2, 51.98, '2022-03-15', 'Delivered'),
('OD-ID-234567', 'CUS-54321', 'TB-GEN123', 1, 35.50, '2022-06-28', 'Shipped'),
('OD-ID-345678', 'CUS-98765', 'BRKPD-BD456', 4, 183.00, '2022-08-10', 'Processing'),
('OD-ID-456789', 'CUS-12345', 'SPRKPLG-AP789', 8, 103.92, '2022-09-20', 'Pending'),
('OD-ID-567890', 'CUS-54321', 'AF-CA345', 3, 59.97, '2022-11-05', 'Shipped'),
('OD-ID-678901', 'CUS-98765', 'STRTMTR-MS450', 1, 75.25, '2023-01-10', 'Delivered'),
('OD-ID-789012', 'CUS-12345', 'ALTR-EX550', 2, 191.00, '2023-03-15', 'Processing'),
('OD-ID-890123', 'CUS-54321', 'WPRBLD-RC333', 5, 79.95, '2023-05-28', 'Pending'),
('OD-ID-901234', 'CUS-98765', 'RSNTR-BR444', 3, 257.97, '2023-07-10', 'Shipped'),
('OD-ID-012345', 'CUS-12345', 'FLFLD-TL777', 4, 58.00, '2023-09-05', 'Processing');

-- PurchaseOrders
INSERT INTO PurchaseOrders (OrderID, SupplierID, OrderDate, TotalAmount, Status) VALUES
('OD-ID-123456', 'SU-ID-12345', '2022-03-15', 103.98, 'Completed'),
('OD-ID-234567', 'SU-ID-54321', '2022-06-28', 75.50, 'Received'),
('OD-ID-345678', 'SU-ID-98765', '2022-08-10', 350.00, 'Sent'),
('OD-ID-456789', 'SU-ID-24680', '2022-09-20', 207.92, 'Pending'),
('OD-ID-567890', 'SU-ID-13579', '2022-11-05', 119.97, 'Received'),
('OD-ID-678901', 'SU-ID-12345', '2023-01-10', 225.25, 'Completed'),
('OD-ID-789012', 'SU-ID-54321', '2023-03-15', 382.00, 'Sent'),
('OD-ID-890123', 'SU-ID-98765', '2023-05-28', 405.95, 'Pending'),
('OD-ID-901234', 'SU-ID-24680', '2023-07-10', 527.97, 'Received'),
('OD-ID-012345', 'SU-ID-13579', '2023-09-05', 232.00, 'Sent');

-- Deliveries
INSERT INTO Deliveries (DeliveryID, OrderID, DeliveryDate, TotalQuantity) VALUES
('DEL-ID-101', 'OD-ID-123456', '2022-04-15 08:30:00', 25),
('DEL-ID-102', 'OD-ID-234567', '2022-06-30 10:45:00', 30),
('DEL-ID-103', 'OD-ID-345678', '2022-08-12 12:00:00', 40),
('DEL-ID-104', 'OD-ID-456789', '2022-09-25 14:20:00', 20),
('DEL-ID-105', 'OD-ID-567890', '2022-11-07 16:40:00', 35),
('DEL-ID-106', 'OD-ID-678901', '2023-01-15 09:00:00', 45),
('DEL-ID-107', 'OD-ID-789012', '2023-03-20 11:15:00', 25),
('DEL-ID-108', 'OD-ID-890123', '2023-05-30 13:30:00', 30),
('DEL-ID-109', 'OD-ID-901234', '2023-07-12 15:50:00', 35),
('DEL-ID-110', 'OD-ID-012345', '2023-09-10 18:00:00', 40);

-- SuppliersPayments
INSERT INTO SuppliersPayments (PaymentID, SupplierID, Amount, PaymentDate) VALUES
('PAY-ID-123456', 'SU-ID-12345', 5000.00, '2022-04-15'),
('PAY-ID-234567', 'SU-ID-54321', 3000.00, '2022-06-30'),
('PAY-ID-345678', 'SU-ID-98765', 1500.00, '2022-08-12'),
('PAY-ID-456789', 'SU-ID-24680', 2000.00, '2022-09-25'),
('PAY-ID-567890', 'SU-ID-13579', 4000.00, '2022-11-07'),
('PAY-ID-678901', 'SU-ID-12345', 3500.00, '2023-01-15'),
('PAY-ID-789012', 'SU-ID-54321', 2800.00, '2023-03-20');














    


