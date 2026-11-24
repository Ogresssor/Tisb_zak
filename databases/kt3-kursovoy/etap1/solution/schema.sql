PRAGMA foreign_keys = ON;
CREATE TABLE salons (
 salon_id INTEGER PRIMARY KEY,
 name TEXT NOT NULL,
 city TEXT NOT NULL,
 address TEXT NOT NULL,
 phone TEXT NOT NULL
);
CREATE TABLE brands (
 brand_id INTEGER PRIMARY KEY,
 name TEXT NOT NULL UNIQUE,
 country TEXT NOT NULL
);
CREATE TABLE models (
 model_id INTEGER PRIMARY KEY,
 brand_id INTEGER NOT NULL REFERENCES brands(brand_id),
 name TEXT NOT NULL,
 body_type TEXT NOT NULL,
 UNIQUE(brand_id,name)
);
CREATE TABLE vehicles (
 vehicle_id INTEGER PRIMARY KEY,
 vin TEXT NOT NULL UNIQUE CHECK(length(vin)=17),
 model_id INTEGER NOT NULL REFERENCES models(model_id),
 salon_id INTEGER NOT NULL REFERENCES salons(salon_id),
 production_year INTEGER NOT NULL CHECK(production_year BETWEEN 1980 AND 2100),
 color TEXT NOT NULL,
 purchase_price NUMERIC NOT NULL CHECK(purchase_price>=0),
 list_price NUMERIC NOT NULL CHECK(list_price>=0),
 status TEXT NOT NULL DEFAULT 'в наличии' CHECK(status IN ('в наличии','зарезервирован','продан')),
 planned_margin NUMERIC GENERATED ALWAYS AS (list_price-purchase_price) VIRTUAL
);
CREATE TABLE customers (
 customer_id INTEGER PRIMARY KEY,
 last_name TEXT NOT NULL,
 first_name TEXT NOT NULL,
 phone TEXT NOT NULL UNIQUE,
 email TEXT
);
CREATE TABLE employees (
 employee_id INTEGER PRIMARY KEY,
 salon_id INTEGER NOT NULL REFERENCES salons(salon_id),
 last_name TEXT NOT NULL,
 first_name TEXT NOT NULL,
 position TEXT NOT NULL
);
CREATE TABLE sales (
 sale_id INTEGER PRIMARY KEY,
 vehicle_id INTEGER NOT NULL UNIQUE REFERENCES vehicles(vehicle_id),
 customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
 employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
 sale_date TEXT NOT NULL,
 base_price NUMERIC NOT NULL CHECK(base_price>=0),
 discount_pct NUMERIC NOT NULL DEFAULT 0 CHECK(discount_pct BETWEEN 0 AND 100),
 final_amount NUMERIC GENERATED ALWAYS AS (ROUND(base_price*(100-discount_pct)/100,2)) VIRTUAL
);
CREATE TABLE payments (
 payment_id INTEGER PRIMARY KEY,
 sale_id INTEGER NOT NULL REFERENCES sales(sale_id),
 payment_date TEXT NOT NULL,
 amount NUMERIC NOT NULL CHECK(amount>0),
 payment_method TEXT NOT NULL CHECK(payment_method IN ('наличные','карта','перевод'))
);
CREATE INDEX idx_vehicles_salon ON vehicles(salon_id);
CREATE INDEX idx_vehicles_model ON vehicles(model_id);
CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_employee ON sales(employee_id);
CREATE INDEX idx_payments_sale ON payments(sale_id);
