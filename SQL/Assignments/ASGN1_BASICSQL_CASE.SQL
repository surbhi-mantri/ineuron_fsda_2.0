USE DATABASE DEMO;
//CREATING SALES TABLE
CREATE OR REPLACE TABLE SM_SALES(
ORDER_ID VARCHAR(40),
ORDER_DATE STRING PRIMARY KEY,
SHIP_DATE STRING,
SHIP_MODE VARCHAR(20),
CUSTOMER_NAME VARCHAR(30),
SEGMENT VARCHAR(20),
STATE VARCHAR(50),
COUNTRY	VARCHAR(40),
MARKET VARCHAR(40),
REGION VARCHAR(40),
PRODUCT_ID	VARCHAR(40),
CATEGORY VARCHAR(35),
SUB_CATEGORY VARCHAR(20),
PRODUCT_NAME STRING,
SALES NUMBER(5,0),
QUANTITY INT,
DISCOUNT DECIMAL(4,3),
PROFIT FLOAT,
SHIPPING_COST DECIMAL(5,2),
ORDER_PRIORITY	VARCHAR(20),
YEAR CHAR(4));

//Change the Primary key to Order Id Column

ALTER TABLE SM_SALES
DROP PRIMARY KEY

ALTER TABLE SM_SALES
ADD PRIMARY KEY(ORDER_ID)

DESCRIBE TABLE SM_SALES

//Check the data type for Order date and Ship date and mention in what data type it should be?
//ADDING NEW COLUMN WITH DATE DATATYPE

ALTER TABLE SM_SALES
ADD COLUMN ORDER_DATE1 DATE

//UPDATED DATA AS ORIGINAL COLUMN
UPDATE SM_SALES SET ORDER_DATE1=TO_DATE(ORDER_DATE)

//DELETED OLD COLUMN
ALTER TABLE SM_SALES
DROP COLUMN ORDER_DATE

ALTER TABLE SM_SALES
ADD COLUMN SHIP_DATE1 DATE

UPDATE SM_SALES SET SHIP_DATE1=TO_DATE(SHIP_DATE)

ALTER TABLE SM_SALES
DROP COLUMN SHIP_DATE
SELECT * FROM SM_SALES

//Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.
CREATE OR REPLACE TABLE SM_SALES AS 
SELECT *,SUBSTR(ORDER_ID,-4,4) AS ORDER_EXTRACT FROM SM_SALES 

//Create a new column called Discount Flag and categorize it based on discount.Use ‘Yes’ if the discount is greater than zero else ‘No’.
CREATE OR REPLACE TABLE SM_SALES AS
SELECT *,
    CASE 
        WHEN DISCOUNT>0 THEN 'Yes'
        ELSE 'No'
    END AS DISCOUNT_FLAG
FROM SM_SALES

//Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.
CREATE OR REPLACE TABLE SM_SALES AS
SELECT *,DATEDIFF('DAYS',ORDER_DATE1,SHIP_DATE1) AS PROCESS_DAYS
FROM SM_SALES
ALTER TABLE SM_SALES DROP COLUMN PROCESS_DAYS
    
/*Create a new column called Rating and then based on the Process dates give rating like given below.
a. If process days less than or equal to 3days then rating should be 5
b. If process days are greater than 3 and less than or equal to 6 then rating
should be 4
c. If process days are greater than 6 and less than or equal to 10 then rating
should be 3
d. If process days are greater than 10 then the rating should be 2.*/

CREATE OR REPLACE TABLE SM_SALES AS
SELECT *,
    CASE 
        WHEN PROCESS_DAYS<=3 THEN 5
        WHEN PROCESS_DAYS BETWEEN 4 AND 6 THEN 4
        WHEN PROCESS_DAYS BETWEEN 7 AND 10 THEN 3
        ELSE 2
    END AS RATING
FROM SM_SALES