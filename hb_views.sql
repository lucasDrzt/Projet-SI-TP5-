-- Vue pour afficher tous les employés
CREATE VIEW ALL_WORKERS AS
SELECT
    id_employee AS worker_id,
    firstname AS first_name,
    lastname AS last_name,
    age,
    start_date
FROM employees
WHERE end_date IS NULL;

-- Vue pour afficher le nombre de jours écoulés depuis l'arrivée de chaque employé
CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT
    worker_id,
    first_name,
    last_name,
    age,
    start_date,
    CURRENT_DATE - start_date AS days_elapsed
FROM ALL_WORKERS;

-- Vue pour afficher les meilleurs fournisseurs
CREATE VIEW BEST_SUPPLIERS AS
SELECT
    s.name AS supplier_name,
    SUM(d.quantity) AS total_quantity
FROM deliveries d
JOIN suppliers s ON d.supplier_id = s.id_supplier
GROUP BY s.name
HAVING SUM(d.quantity) > 1000
ORDER BY total_quantity DESC;

-- Vue pour afficher les usines ayant assemblé chaque robot
CREATE VIEW ROBOTS_FACTORIES AS
SELECT
    r.id_robot AS robot_id,
    r.model_name,
    r.created_at AS production_date,
    f.name AS factory_name
FROM robots r
JOIN factories f ON r.factory_id = f.id_factory;
