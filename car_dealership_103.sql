-- Creating tables in Car Dealership

CREATE TABLE "customer" (
  "customer_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "address" VARCHAR(100),
  "email" VARCHAR(100),
  "phone_number" VARCHAR(50),
  "billing_info" VARCHAR(100)
);

CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);

CREATE TABLE "parts" (
  "parts_id" SERIAL PRIMARY KEY,
  "item_name" VARCHAR(50),
  "cost" NUMERIC(8,2)
);

CREATE TABLE "car" (
  "car_id" SERIAL,
  "customer_id" INTEGER,
  "make" VARCHAR(50),
  "model" VARCHAR(50),
  "year" INTEGER,
  PRIMARY KEY ("car_id"),
    FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id")
);

CREATE TABLE "sales" (
  "sales_id" SERIAL,
  "amount" NUMERIC(8,2),
  "date" DATE,
  "salesperson_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("sales_id"),
    FOREIGN KEY ("salesperson_id") REFERENCES "salesperson"("salesperson_id"),
	FOREIGN KEY ("car_id") REFERENCES "car"("car_id")
);

CREATE TABLE "service" (
  "service_id" SERIAL,
  "service_type" VARCHAR(50),
  "parts_id" INTEGER,
  "amount" NUMERIC(8,2),
  "date" DATE,
  "mechanic_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("service_id"),
    FOREIGN KEY ("mechanic_id") REFERENCES "mechanic"("mechanic_id"),
	FOREIGN KEY ("parts_id") REFERENCES "parts"("parts_id"),
	FOREIGN KEY ("car_id") REFERENCES "car"("car_id")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "customer_id" INTEGER,
  "service_id" INTEGER,
  "sales_id" INTEGER,
  "total_amount" NUMERIC(8,2),
  "date" DATE,
  "tax" NUMERIC(8,2),
  PRIMARY KEY ("invoice_id"),
    FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id"),
	FOREIGN KEY ("service_id") REFERENCES "service"("service_id"),
	FOREIGN KEY ("sales_id") REFERENCES "sales"("sales_id")
);


-- Creating functions to insert data into our tables

---- Function to add data to customer table
CREATE FUNCTION add_customer (
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_address VARCHAR(100),
	_email VARCHAR(100),
	_phone_number VARCHAR(50),
	_billing_info VARCHAR(100)
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO customer(first_name, last_name, address, email, phone_number, billing_info)
	VALUES (_first_name, _last_name, _address, _email, _phone_number, _billing_info);
END;
$MAIN$
LANGUAGE plpgsql;

---- Function to add data into cars table
CREATE FUNCTION add_car (
	_customer_id INTEGER,
	_make VARCHAR(50),
	_model VARCHAR(50),
	_year INTEGER
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO car(customer_id, make, model, "year")
	VALUES (_customer_id, _make, _model, _year);
END;
$MAIN$
LANGUAGE plpgsql;

-- Function to add data into salesperson table
CREATE FUNCTION add_salesperson (
	_first_name VARCHAR(50),
	_last_name VARCHAR(50)
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO salesperson(first_name, last_name)
	VALUES (_first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

---- Function to add data into sales table
CREATE FUNCTION add_sale (
	_amount NUMERIC(8,2),
	_date DATE,
	_salesperson_id INTEGER,
	_car_id INTEGER
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO sales(amount, "date", salesperson_id, car_id)
	VALUES (_amount, _date, _salesperson_id, _car_id);
END;
$MAIN$
LANGUAGE plpgsql;

---- Function to add data into mechanic table
CREATE FUNCTION add_mechanic (
	_first_name VARCHAR(50),
	_last_name VARCHAR(50)
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO mechanic(first_name, last_name)
	VALUES (_first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

-- Function to add data into service table
CREATE FUNCTION add_service (
	_service_type VARCHAR(50),
	_parts_id INTEGER,
	_amount NUMERIC(8,2),
	_date DATE,
	_mechanic_id INTEGER,
	_car_id INTEGER
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO service(service_type, parts_id, amount, "date", mechanic_id, car_id)
	VALUES (_service_type, _parts_id, _amount, _date, _mechanic_id, _car_id);
END;
$MAIN$
LANGUAGE plpgsql;

-- Function to add data into parts table
CREATE FUNCTION add_part (
	_item_name VARCHAR(50),
	_cost NUMERIC(8,2)
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO parts(item_name, "cost")
	VALUES (_item_name, _cost);
END;
$MAIN$
LANGUAGE plpgsql;

-- Function to add data into invoice table
CREATE FUNCTION add_invoice (
	_customer_id INTEGER,
	_service_id INTEGER,
	_sales_id INTEGER,
	_total_amount NUMERIC(8,2),
	_date DATE,
	_tax NUMERIC(8,2)
)
RETURNS void
AS
$MAIN$
BEGIN
	INSERT INTO invoice(customer_id, service_id, sales_id, total_amount, "date", tax)
	VALUES (_customer_id, _service_id, _sales_id, _total_amount, _date, _tax);
END;
$MAIN$
LANGUAGE plpgsql;

-- Inserting data into tables using our functions
SELECT add_customer('Kathy', 'Vu', '123 Potato Street', 'kay.vu13@gmail.com', '123-456-7890', '1234 5678 9012 3456 111 11/2024');
SELECT add_customer('Michael', 'Scott', '123 Office Street', 'mscott@dundermifflin.com', '987-654-3210', '9876 5432 1098 7654 222 01/2024');
SELECT add_customer('Steve', 'Rogers', '123 Avenger Street', 'captain@avengers.com', '234-567-8901', '2345 6789 0123 4567 333 02/2024');

SELECT add_car(1, 'Honda', 'CR-V', 2011);
SELECT add_car(2, 'Jeep', 'Cherokee', 2020);
SELECT add_car(3, 'Ford', 'Mustang', 2022);

SELECT add_salesperson('Jim', 'Halpert');
SELECT add_salesperson('Dwight', 'Schrute');
SELECT add_salesperson('Ryan', 'Howard');

SELECT add_mechanic('Darryl', 'Philbin');
SELECT add_mechanic('Kevin', 'Malone');
SELECT add_mechanic('Stanley', 'Hudson');

SELECT add_part('spark plug', 10.00);
SELECT add_part('catalytic converter', 1000.00);
SELECT add_part('headlight', 30.00);
SELECT add_part('taillight', 30.00);
SELECT add_part('compressor', 500.00);
SELECT add_part('battery', 150.00);
SELECT add_part('tire', 100.00);

SELECT add_sale(30000, CURRENT_DATE, 1, 3);
SELECT add_sale(28000, CURRENT_DATE, 3, 2);

SELECT add_service('replace headlight', 3, 20.00, CURRENT_DATE, 1, 1);
SELECT add_service('replace taillight', 4, 20.00, CURRENT_DATE, 2, 1);
SELECT add_service('replace battery', 6, 50.00, CURRENT_DATE, 3, 1);

UPDATE service
SET amount = (amount + parts.cost)
FROM parts
WHERE service.parts_id = parts.parts_id;

SELECT add_invoice(3, null, 1, 30000, CURRENT_DATE, 1875.00);
SELECT add_invoice(2, null, 2, 28000, CURRENT_DATE, 1750.00);
SELECT add_invoice(1, 1, NULL, 50.00, CURRENT_DATE, 3.13);
SELECT add_invoice(1, 2, NULL, 50.00, CURRENT_DATE, 3.13);
SELECT add_invoice(1, 3, NULL, 200.00, CURRENT_DATE, 12.50);