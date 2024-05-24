-- Fonction pour intercepter les insertions dans la vue all_workers_elapsed
CREATE OR REPLACE FUNCTION trg_insert_all_workers_elapsed() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employees (id_employee, firstname, lastname, age, start_date, factory_id)
    VALUES (NEW.id_employee, NEW.firstname, NEW.lastname, NEW.age, NEW.start_date, NEW.factory_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_insert_all_workers_elapsed
INSTEAD OF INSERT ON all_workers_elapsed
FOR EACH ROW
EXECUTE FUNCTION trg_insert_all_workers_elapsed();

-- Fonction pour enregistrer la date d'ajout d'un robot dans la table audit_robot
CREATE OR REPLACE FUNCTION trg_audit_robot_insert() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_robot (robot_id, created_at)
    VALUES (NEW.id_robot, CURRENT_DATE);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_insert_robot
AFTER INSERT ON robots
FOR EACH ROW
EXECUTE FUNCTION trg_audit_robot_insert();

-- Fonction pour vérifier la cohérence des usines avant modification
CREATE OR REPLACE FUNCTION trg_check_factories() RETURNS TRIGGER AS $$
DECLARE
    nb_factories INT;
    nb_worker_tables INT;
BEGIN
    SELECT COUNT(*) INTO nb_factories FROM factories;
    SELECT COUNT(*) INTO nb_worker_tables FROM pg_tables WHERE tablename LIKE 'employees%';

    IF nb_factories <> nb_worker_tables THEN
        RAISE EXCEPTION 'Number of factories does not match number of worker tables';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_modify_factories
BEFORE INSERT OR UPDATE OR DELETE ON factories
FOR EACH STATEMENT
EXECUTE FUNCTION trg_check_factories();
