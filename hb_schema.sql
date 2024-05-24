-- hb_schema.sql
CREATE TABLE factories (
    id_factory SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id_employee SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    age INT,
    start_date DATE,
    end_date DATE,
    factory_id INT REFERENCES factories(id_factory)
);

CREATE TABLE suppliers (
    id_supplier SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE deliveries (
    id_delivery SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES suppliers(id_supplier),
    factory_id INT REFERENCES factories(id_factory),
    delivery_date DATE,
    quantity INT,
    received_by INT REFERENCES employees(id_employee)
);

CREATE TABLE robots (
    id_robot SERIAL PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL,
    factory_id INT REFERENCES factories(id_factory),
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE stock (
    id_stock SERIAL PRIMARY KEY,
    robot_id INT REFERENCES robots(id_robot),
    factory_id INT REFERENCES factories(id_factory),
    quantity INT
);

CREATE TABLE audit_robot (
    id_audit SERIAL PRIMARY KEY,
    robot_id INT REFERENCES robots(id_robot),
    created_at DATE DEFAULT CURRENT_DATE
);
