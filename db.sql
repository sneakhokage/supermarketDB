USE [master]
GO
/****** Object:  Database [SupermarketDB]    Script Date: 27.12.2024 11:16:00 ******/
CREATE DATABASE [SupermarketDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SupermarketDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SupermarketDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SupermarketDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SupermarketDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SupermarketDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SupermarketDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SupermarketDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SupermarketDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SupermarketDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SupermarketDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SupermarketDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SupermarketDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SupermarketDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SupermarketDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SupermarketDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SupermarketDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SupermarketDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SupermarketDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SupermarketDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SupermarketDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SupermarketDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SupermarketDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SupermarketDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SupermarketDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SupermarketDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SupermarketDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SupermarketDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SupermarketDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SupermarketDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SupermarketDB] SET  MULTI_USER 
GO
ALTER DATABASE [SupermarketDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SupermarketDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SupermarketDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SupermarketDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SupermarketDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SupermarketDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SupermarketDB', N'ON'
GO
ALTER DATABASE [SupermarketDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SupermarketDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SupermarketDB]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products_History]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products_History](
	[product_id] [int] NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[category_id] [int] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[supplier_id] [int] NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
/****** Object:  Index [ix_Products_History]    Script Date: 27.12.2024 11:16:00 ******/
CREATE CLUSTERED INDEX [ix_Products_History] ON [dbo].[Products_History]
(
	[ValidTo] ASC,
	[ValidFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[category_id] [int] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[supplier_id] [int] NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[Products_History])
)
GO
/****** Object:  View [dbo].[ProductsWithCategories]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductsWithCategories] AS
SELECT 
    p.product_name AS ProductName,
    c.category_name AS CategoryName,
    p.price AS Price,
    p.stock_quantity AS StockQuantity
FROM 
    Products p
JOIN 
    Categories c ON p.category_id = c.category_id;
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NULL,
	[phone] [nvarchar](20) NULL,
	[address] [nvarchar](255) NULL,
	[city] [nvarchar](50) NULL,
	[postal_code] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders_History]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders_History](
	[order_id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [date] NOT NULL,
	[total_amount] [decimal](10, 2) NOT NULL,
	[employee_id] [int] NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
/****** Object:  Index [ix_Orders_History]    Script Date: 27.12.2024 11:16:00 ******/
CREATE CLUSTERED INDEX [ix_Orders_History] ON [dbo].[Orders_History]
(
	[ValidTo] ASC,
	[ValidFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [date] NOT NULL,
	[total_amount] [decimal](10, 2) NOT NULL,
	[employee_id] [int] NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[Orders_History])
)
GO
/****** Object:  View [dbo].[OrdersWithCustomerInfo]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[OrdersWithCustomerInfo] AS
SELECT 
    o.order_id AS OrderID,
    c.first_name AS FirstName,
    c.last_name AS LastName,
    o.order_date AS OrderDate,
    o.total_amount AS TotalAmount
FROM 
    Orders o
JOIN 
    Customers c ON o.customer_id = c.customer_id;
GO
/****** Object:  Table [dbo].[Suppliers_History]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers_History](
	[supplier_id] [int] NOT NULL,
	[supplier_name] [nvarchar](100) NOT NULL,
	[contact_name] [nvarchar](100) NULL,
	[contact_phone] [nvarchar](20) NULL,
	[contact_email] [nvarchar](100) NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
/****** Object:  Index [ix_Suppliers_History]    Script Date: 27.12.2024 11:16:00 ******/
CREATE CLUSTERED INDEX [ix_Suppliers_History] ON [dbo].[Suppliers_History]
(
	[ValidTo] ASC,
	[ValidFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_name] [nvarchar](100) NOT NULL,
	[contact_name] [nvarchar](100) NULL,
	[contact_phone] [nvarchar](20) NULL,
	[contact_email] [nvarchar](100) NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[Suppliers_History])
)
GO
/****** Object:  View [dbo].[ProductsWithSuppliers]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ProductsWithSuppliers] AS
SELECT 
    p.product_name AS ProductName,
    s.supplier_name AS SupplierName,
    p.price AS Price
FROM 
    Products p
JOIN 
    Suppliers s ON p.supplier_id = s.supplier_id;
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[order_item_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price_per_item] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderDetails]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[OrderDetails] AS
SELECT 
    oi.order_item_id AS OrderItemID,
    o.order_id AS OrderID,
    p.product_name AS ProductName,
    oi.quantity AS Quantity,
    oi.price_per_item AS PricePerItem
FROM 
    OrderItems oi
JOIN 
    Orders o ON oi.order_id = o.order_id
JOIN 
    Products p ON oi.product_id = p.product_id;
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[discount_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[discount_percentage] [decimal](5, 2) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductDiscounts]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ProductDiscounts] AS
SELECT 
    p.product_name AS ProductName,
    d.discount_percentage AS DiscountPercentage,
    d.start_date AS StartDate,
    d.end_date AS EndDate
FROM 
    Discounts d
JOIN 
    Products p ON d.product_id = p.product_id;
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[payment_date] [date] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[payment_method] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PaymentsWithOrderInfo]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PaymentsWithOrderInfo] AS
SELECT 
    p.payment_id AS PaymentID,
    o.order_id AS OrderID,
    p.amount AS Amount,
    p.payment_date AS PaymentDate,
    p.payment_method AS PaymentMethod
FROM 
    Payments p
JOIN 
    Orders o ON p.order_id = o.order_id;
GO
/****** Object:  Table [dbo].[Employees_History]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees_History](
	[employee_id] [int] NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[job_title] [nvarchar](100) NULL,
	[hire_date] [date] NULL,
	[salary] [decimal](10, 2) NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
/****** Object:  Index [ix_Employees_History]    Script Date: 27.12.2024 11:16:00 ******/
CREATE CLUSTERED INDEX [ix_Employees_History] ON [dbo].[Employees_History]
(
	[ValidTo] ASC,
	[ValidFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[job_title] [nvarchar](100) NULL,
	[hire_date] [date] NULL,
	[salary] [decimal](10, 2) NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[Employees_History])
)
GO
/****** Object:  Table [dbo].[CustomerFeedback]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFeedback](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[feedback_date] [date] NOT NULL,
	[feedback_text] [nvarchar](500) NULL,
	[rating] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[inventory_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[stock_in] [int] NOT NULL,
	[stock_out] [int] NOT NULL,
	[last_updated] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotions]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotions](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_name] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[product_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Returns]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Returns](
	[return_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[return_date] [date] NOT NULL,
	[reason] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[return_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipments]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipments](
	[shipment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[shipper_id] [int] NULL,
	[shipment_date] [date] NOT NULL,
	[delivery_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[shipment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[shipper_id] [int] IDENTITY(1,1) NOT NULL,
	[shipper_name] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[shipper_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_ValidFrom]  DEFAULT (sysutcdatetime()) FOR [ValidFrom]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_ValidTo]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [ValidTo]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_ValidFrom]  DEFAULT (sysutcdatetime()) FOR [ValidFrom]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_ValidTo]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [ValidTo]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_ValidFrom]  DEFAULT (sysutcdatetime()) FOR [ValidFrom]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_ValidTo]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [ValidTo]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF_Suppliers_ValidFrom]  DEFAULT (sysutcdatetime()) FOR [ValidFrom]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF_Suppliers_ValidTo]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [ValidTo]
GO
ALTER TABLE [dbo].[CustomerFeedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[CustomerFeedback] CHECK CONSTRAINT [FK_Feedback_Customers]
GO
ALTER TABLE [dbo].[Discounts]  WITH CHECK ADD  CONSTRAINT [FK_Discounts_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Discounts] CHECK CONSTRAINT [FK_Discounts_Products]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Products]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([employee_id])
REFERENCES [dbo].[Employees] ([employee_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[Promotions]  WITH CHECK ADD  CONSTRAINT [FK_Promotions_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Promotions] CHECK CONSTRAINT [FK_Promotions_Products]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Orders]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Products]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [FK_Shipments_Orders]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Shippers] FOREIGN KEY([shipper_id])
REFERENCES [dbo].[Shippers] ([shipper_id])
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [FK_Shipments_Shippers]
GO
ALTER TABLE [dbo].[CustomerFeedback]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateOrder]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Процедура для створення замовлення і розрахунку загальної вартості
CREATE   PROCEDURE [dbo].[sp_CreateOrder]
    @order_id INT OUTPUT,
    @customer_id INT,
    @employee_id INT,
    @order_date DATE,
    @products NVARCHAR(MAX) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @total_amount DECIMAL(18,2) = 0; 
    DECLARE @tempProducts TABLE (
        product_id INT,
        quantity INT,
        price DECIMAL(18,2)
    );

    INSERT INTO @tempProducts (product_id, quantity, price)
    SELECT 
        JSON_VALUE(p.value, '$.product_id') AS product_id,
        JSON_VALUE(p.value, '$.quantity') AS quantity,
        JSON_VALUE(p.value, '$.price') AS price
    FROM OPENJSON(@products) AS p;

    SELECT @total_amount = SUM(quantity * price) 
    FROM @tempProducts;

    INSERT INTO Orders (customer_id, order_date, total_amount, employee_id)
    VALUES (@customer_id, @order_date, @total_amount, @employee_id);

    SET @order_id = SCOPE_IDENTITY();

    INSERT INTO OrderItems (order_id, product_id, quantity, price_per_item)
    SELECT @order_id, product_id, quantity, price
    FROM @tempProducts;

    SELECT 'Order Created Successfully. Total Amount: ' + CAST(@total_amount AS NVARCHAR);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategories]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetCategories]
    @CategoryName NVARCHAR(100) = NULL, 
    @PageSize INT = 20,                 
    @PageNumber INT = 1,                
    @SortColumn NVARCHAR(128) = 'category_name', 
    @SortDirection BIT = 0              
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageSize <= 0 OR @PageNumber <= 0
    BEGIN
        PRINT 'Incorrect value of @PageSize or @PageNumber';
        RETURN;
    END

    SELECT *
    FROM dbo.Categories
    WHERE (@CategoryName IS NULL OR category_name LIKE @CategoryName + '%')
    ORDER BY 
        CASE 
            WHEN @SortColumn = 'category_id' AND @SortDirection = 0 THEN category_id
            WHEN @SortColumn = 'category_name' AND @SortDirection = 0 THEN category_name
            WHEN @SortColumn = 'category_id' AND @SortDirection = 1 THEN category_id
            WHEN @SortColumn = 'category_name' AND @SortDirection = 1 THEN category_name
            ELSE NULL  
        END 
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProducts]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetProducts]
    @CategoryID INT = NULL,            
    @ProductName NVARCHAR(100) = NULL,  
    @PageSize INT = 20,                 
    @PageNumber INT = 1,                
    @SortColumn NVARCHAR(128) = 'product_id', 
    @SortDirection BIT = 0              
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageSize <= 0 OR @PageNumber <= 0
    BEGIN
        PRINT 'Incorrect value of @PageSize or @PageNumber';
        RETURN;
    END

    SELECT *
    FROM dbo.Products
    WHERE (@CategoryID IS NULL OR category_id = @CategoryID)
      AND (@ProductName IS NULL OR product_name LIKE @ProductName + '%')
    ORDER BY 
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'product_id' THEN product_id
                WHEN 'product_name' THEN product_name
                WHEN 'price' THEN price
                WHEN 'stock_quantity' THEN stock_quantity
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'product_id' THEN product_id
                WHEN 'product_name' THEN product_name
                WHEN 'price' THEN price
                WHEN 'stock_quantity' THEN stock_quantity
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END; 

GO
/****** Object:  StoredProcedure [dbo].[sp_GetPromotions]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_GetPromotions]
    @PromotionName NVARCHAR(100) = NULL, 
    @PageSize INT = 20,                  
    @PageNumber INT = 1,                 
    @SortColumn NVARCHAR(128) = 'promotion_id', 
    @SortDirection BIT = 0               
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageSize <= 0 OR @PageNumber <= 0
    BEGIN
        PRINT 'Incorrect value of @PageSize or @PageNumber';
        RETURN;
    END

    SELECT *
    FROM dbo.Promotions
    WHERE (@PromotionName IS NULL OR promotion_name LIKE @PromotionName + '%')
    ORDER BY 
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'promotion_id' THEN promotion_id
                WHEN 'promotion_name' THEN promotion_name
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'promotion_id' THEN promotion_id
                WHEN 'promotion_name' THEN promotion_name
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSuppliers]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_GetSuppliers]
    @SupplierName NVARCHAR(100) = NULL, 
    @ContactName NVARCHAR(100) = NULL,  
    @PageSize INT = 20,                 
    @PageNumber INT = 1,                
    @SortColumn NVARCHAR(128) = 'supplier_id', 
    @SortDirection BIT = 0              
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageSize <= 0 OR @PageNumber <= 0
    BEGIN
        PRINT 'Incorrect value of @PageSize or @PageNumber';
        RETURN;
    END

    SELECT *
    FROM dbo.Suppliers
    WHERE (@SupplierName IS NULL OR supplier_name LIKE @SupplierName + '%')
      AND (@ContactName IS NULL OR contact_name LIKE @ContactName + '%')
    ORDER BY 
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'supplier_id' THEN supplier_id
                WHEN 'supplier_name' THEN supplier_name
                WHEN 'contact_name' THEN contact_name
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'supplier_id' THEN supplier_id
                WHEN 'supplier_name' THEN supplier_name
                WHEN 'contact_name' THEN contact_name
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PayForOrder]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Процедура для оплати замовлення
CREATE   PROCEDURE [dbo].[sp_PayForOrder]
    @order_id INT,
    @payment_date DATE,
    @amount DECIMAL(10, 2),
    @payment_method NVARCHAR(50),
    @payment_id INT OUTPUT
AS
BEGIN
    BEGIN TRY
        -- Створення платежу
        EXEC dbo.sp_SetPayment
            @payment_id = @payment_id OUTPUT,
            @order_id = @order_id,
            @payment_date = @payment_date,
            @amount = @amount,
            @payment_method = @payment_method;

        PRINT 'Payment successfully processed. Payment ID: ' + CAST(@payment_id AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while processing payment: ' + ERROR_MESSAGE();
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetCategory]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Категорії
CREATE   PROCEDURE [dbo].[sp_SetCategory]
    @category_name NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        INSERT INTO dbo.Categories (category_name)
        VALUES (@category_name);
    END TRY
    BEGIN CATCH
        PRINT 'Помилка: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SetCustomer]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Відвідувачі
CREATE   PROCEDURE [dbo].[sp_SetCustomer]
    @first_name NVARCHAR(50),
    @last_name NVARCHAR(50),
    @email NVARCHAR(100),
    @phone NVARCHAR(20) = NULL, 
    @address NVARCHAR(255) = NULL,
    @city NVARCHAR(100) = NULL,
    @postal_code NVARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        INSERT INTO dbo.Customers (first_name, last_name, email, phone, address, city, postal_code)
        VALUES (@first_name, @last_name, @email, @phone, @address, @city, @postal_code);
    END TRY
    BEGIN CATCH
        PRINT 'Помилка: ' + ERROR_MESSAGE();
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetCustomerFeedback]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Відгуки відвідувачів
CREATE   PROCEDURE [dbo].[sp_SetCustomerFeedback]
    @feedback_id INT = NULL OUTPUT,  
    @customer_id INT = NULL,
    @feedback_date DATE = NULL,
    @feedback_text NVARCHAR(500) = NULL,
    @rating INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @feedback_id IS NULL
        BEGIN
            SET @feedback_id = 1 + ISNULL((SELECT TOP(1) feedback_id FROM dbo.CustomerFeedback ORDER BY feedback_id DESC), 0);
            
            INSERT INTO dbo.CustomerFeedback (customer_id, feedback_date, feedback_text, rating)
            VALUES (@customer_id, @feedback_date, @feedback_text, @rating);
        END
        ELSE
        BEGIN
            UPDATE dbo.CustomerFeedback
            SET customer_id = ISNULL(@customer_id, customer_id),
                feedback_date = ISNULL(@feedback_date, feedback_date),
                feedback_text = ISNULL(@feedback_text, feedback_text),
                rating = ISNULL(@rating, rating)
            WHERE feedback_id = @feedback_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();  
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SetDiscount]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Знижки
CREATE   PROCEDURE [dbo].[sp_SetDiscount]
    @discount_id INT = NULL OUTPUT,  -- Вихідний параметр для discount_id
    @product_id INT = NULL,          -- ID продукту
    @discount_percentage DECIMAL = NULL, -- Відсоток знижки
    @start_date DATE = NULL,         -- Дата початку дії знижки
    @end_date DATE = NULL            -- Дата закінчення дії знижки
AS
BEGIN
    BEGIN TRY
        -- Якщо @discount_id не задано, то вставляємо новий запис
        IF @discount_id IS NULL
        BEGIN
            -- Генерація нового discount_id
            SET @discount_id = 1 + ISNULL((SELECT TOP(1) discount_id FROM dbo.Discounts ORDER BY discount_id DESC), 0);
            
            INSERT INTO dbo.Discounts (product_id, discount_percentage, start_date, end_date)
            VALUES (@product_id, @discount_percentage, @start_date, @end_date);
        END
        ELSE
        BEGIN
            -- Оновлення існуючого запису знижки за discount_id
            UPDATE dbo.Discounts
            SET product_id = ISNULL(@product_id, product_id),
                discount_percentage = ISNULL(@discount_percentage, discount_percentage),
                start_date = ISNULL(@start_date, start_date),
                end_date = ISNULL(@end_date, end_date)
            WHERE discount_id = @discount_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();  -- Вивести повідомлення про помилку
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetEmployee]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Працівники
CREATE   PROCEDURE [dbo].[sp_SetEmployee]
    @employee_id INT = NULL, 
    @first_name NVARCHAR(50) = NULL,
    @last_name NVARCHAR(50) = NULL,
    @job_title NVARCHAR(100) = NULL,
    @hire_date DATE = NULL,
    @salary DECIMAL = NULL,
    @ValidFrom DATETIME2 = NULL,
    @ValidTo DATETIME2 = NULL
AS
BEGIN
    BEGIN TRY
        IF @employee_id IS NULL
        BEGIN
            INSERT INTO dbo.Employees (first_name, last_name, job_title, hire_date, salary)
            VALUES (@first_name, @last_name, @job_title, @hire_date, @salary)
        END
        ELSE
        BEGIN
            UPDATE dbo.Employees
            SET 
                first_name = ISNULL(@first_name, first_name),
                last_name = ISNULL(@last_name, last_name),
                job_title = ISNULL(@job_title, job_title),
                hire_date = ISNULL(@hire_date, hire_date),
                salary = ISNULL(@salary, salary)
            WHERE employee_id = @employee_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetInventory]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Інвентар
CREATE   PROCEDURE [dbo].[sp_SetInventory]
    @inventory_id INT = NULL OUTPUT,     -- Вихідний параметр для inventory_id
    @product_id INT = NULL,              -- ID продукту
    @stock_in INT = NULL,                -- Кількість товару, яка надійшла
    @stock_out INT = NULL,               -- Кількість товару, яка була продана/використана
    @last_updated DATE = NULL            -- Дата останнього оновлення
AS
BEGIN
    BEGIN TRY
        -- Якщо @inventory_id не задано, то вставляємо новий запис
        IF @inventory_id IS NULL
        BEGIN
            -- Генерація нового inventory_id
            SET @inventory_id = 1 + ISNULL((SELECT TOP(1) inventory_id FROM dbo.Inventory ORDER BY inventory_id DESC), 0);
            
            INSERT INTO dbo.Inventory (product_id, stock_in, stock_out, last_updated)
            VALUES (@product_id, @stock_in, @stock_out, @last_updated);
        END
        ELSE
        BEGIN
            -- Оновлення існуючого запису інвентарю за inventory_id
            UPDATE dbo.Inventory
            SET product_id = ISNULL(@product_id, product_id),
                stock_in = ISNULL(@stock_in, stock_in),
                stock_out = ISNULL(@stock_out, stock_out),
                last_updated = ISNULL(@last_updated, last_updated)
            WHERE inventory_id = @inventory_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();  -- Вивести повідомлення про помилку
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetOrder]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Замовлення
CREATE   PROCEDURE [dbo].[sp_SetOrder]
    @order_id INT = NULL OUTPUT,  
    @customer_id INT = NULL,
    @order_date DATE = NULL,
    @total_amount DECIMAL = NULL,
    @employee_id INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @order_id IS NULL
        BEGIN
            SET @order_id = 1 + ISNULL((SELECT TOP(1) order_id FROM dbo.Orders ORDER BY order_id DESC), 0);
            
            INSERT INTO dbo.Orders (customer_id, order_date, total_amount, employee_id)
            VALUES (@customer_id, @order_date, @total_amount, @employee_id);
        END
        ELSE
        BEGIN
            UPDATE dbo.Orders
            SET customer_id = ISNULL(@customer_id, customer_id),
                order_date = ISNULL(@order_date, order_date),
                total_amount = ISNULL(@total_amount, total_amount),
                employee_id = ISNULL(@employee_id, employee_id)
            WHERE order_id = @order_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();  
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetOrderItem]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_SetOrderItem]
    @order_item_id INT = NULL OUTPUT, 
    @order_id INT,                    
    @product_id INT,                 
    @quantity INT,                   
    @price_per_item DECIMAL(10, 2)    
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @order_item_id IS NULL
        BEGIN
            INSERT INTO dbo.OrderItems (order_id, product_id, quantity, price_per_item)
            VALUES (@order_id, @product_id, @quantity, @price_per_item);

            SET @order_item_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE dbo.OrderItems
            SET 
                order_id = @order_id,
                product_id = @product_id,
                quantity = @quantity,
                price_per_item = @price_per_item
            WHERE order_item_id = @order_item_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SetPayment]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Оплата
CREATE   PROCEDURE [dbo].[sp_SetPayment]
    @payment_id INT = NULL OUTPUT,        
    @order_id INT = NULL,               
    @payment_date DATE = NULL,       
    @amount DECIMAL = NULL,            
    @payment_method NVARCHAR(50) = NULL  
AS
BEGIN
    BEGIN TRY
        IF @payment_id IS NULL
        BEGIN
            SET @payment_id = 1 + ISNULL((SELECT TOP(1) payment_id FROM dbo.Payments ORDER BY payment_id DESC), 0);
            
            INSERT INTO dbo.Payments (order_id, payment_date, amount, payment_method)
            VALUES (@order_id, @payment_date, @amount, @payment_method);
        END
        ELSE
        BEGIN
            UPDATE dbo.Payments
            SET order_id = ISNULL(@order_id, order_id),
                payment_date = ISNULL(@payment_date, payment_date),
                amount = ISNULL(@amount, amount),
                payment_method = ISNULL(@payment_method, payment_method)
            WHERE payment_id = @payment_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE(); 
    END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SetProduct]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Продукти
CREATE   PROCEDURE [dbo].[sp_SetProduct]
    @product_id INT = NULL,
    @product_name NVARCHAR(100) = NULL,
    @category_id INT = NULL,
    @price DECIMAL = NULL,
    @stock_quantity INT = NULL,
    @supplier_id INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @product_id IS NULL
        BEGIN
            INSERT INTO dbo.Products (product_name, category_id, price, stock_quantity, supplier_id)
            VALUES (@product_name, @category_id, @price, @stock_quantity, @supplier_id);
        END
        ELSE
        BEGIN
            UPDATE dbo.Products
            SET 
                product_name = ISNULL(@product_name, product_name),
                category_id = ISNULL(@category_id, category_id),
                price = ISNULL(@price, price),
                stock_quantity = ISNULL(@stock_quantity, stock_quantity),
                supplier_id = ISNULL(@supplier_id, supplier_id)
            WHERE product_id = @product_id;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetReturn]    Script Date: 27.12.2024 11:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SetReturn]
    @return_id INT OUTPUT,            
    @order_id INT,                   
    @product_id INT,                 
    @return_date DATE,                
    @reason NVARCHAR(255)             
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [Returns] WHERE return_id = @return_id)
    BEGIN
        UPDATE [Returns]
        SET order_id = @order_id,
            product_id = @product_id,
            return_date = @return_date,
            reason = @reason
        WHERE return_id = @return_id;
    END
    ELSE
    BEGIN
        INSERT INTO [Returns] (order_id, product_id, return_date, reason)
        VALUES (@order_id, @product_id, @return_date, @reason);
        SET @return_id = SCOPE_IDENTITY();
    END
END;
GO
USE [master]
GO
ALTER DATABASE [SupermarketDB] SET  READ_WRITE 
GO
