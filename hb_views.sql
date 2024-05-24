-- hb_views.sql
CREATE VIEW ALL_WORKERS AS
SELECT
    e.id_employee,
    e.firstname,
    e.lastname,
    e.age,
    e.start_date,
    f.name AS factory_name
FROM employees e
JOIN factories f ON e.factory_id = f.id_factory
WHERE e.end_date IS NULL;

CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT firstname, lastname, age, start_date, 
       CURRENT_DATE - start_date AS days_elapsed
FROM ALL_WORKERS;

CREATE VIEW BEST_SUPPLIERS AS
SELECT s.name, SUM(d.quantity) as total_quantity
FROM suppliers s
JOIN deliveries d ON s.id = d.supplier_id
GROUP BY s.name
HAVING SUM(d.quantity) > 1000
ORDER BY total_quantity DESC;

CREATE VIEW ROBOTS_FACTORIES AS
SELECT
    r.id_robot,
    r.model_name,
    r.created_at,
    f.name AS factory_name
FROM robots r
JOIN factories f ON r.factory_id = f.id_factory;
