-- my_funcs_procs.sql
CREATE FUNCTION GET_NB_WORKERS(factory_id INT) RETURNS INT AS $$
DECLARE
    nb_workers INT;
BEGIN
    SELECT COUNT(*) INTO nb_workers
    FROM employees
    WHERE factory_id = $1 AND end_date IS NULL;
    RETURN nb_workers;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION GET_NB_BIG_ROBOTS() RETURNS INT AS $$
DECLARE
    nb_big_robots INT;
BEGIN
    SELECT COUNT(*) INTO nb_big_robots
    FROM robots
    WHERE id IN (SELECT robot_id FROM stock WHERE quantity > 3);
    RETURN nb_big_robots;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION GET_BEST_SUPPLIER() RETURNS VARCHAR AS $$
DECLARE
    best_supplier VARCHAR(100);
BEGIN
    SELECT name INTO best_supplier
    FROM BEST_SUPPLIERS
    ORDER BY total_quantity DESC
    LIMIT 1;
    RETURN best_supplier;
END;
$$ LANGUAGE plpgsql;

CREATE PROCEDURE SEED_DATA_WORKERS(nb_workers INT, factory_id INT) AS $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..nb_workers LOOP
        INSERT INTO employees (firstname, lastname, start_date, factory_id)
        VALUES ('worker_f_' || i, 'worker_l_' || i, (SELECT DATE '2065-01-01' + (RANDOM() * (DATE '2070-01-01' - DATE '2065-01-01'))), factory_id);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE PROCEDURE ADD_NEW_ROBOT(model_name VARCHAR) AS $$
BEGIN
    INSERT INTO robots (model_name) VALUES (model_name);
END;
$$ LANGUAGE plpgsql;
