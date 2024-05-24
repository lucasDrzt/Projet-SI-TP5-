-- my_triggers.sql
CREATE OR REPLACE FUNCTION prevent_modifications() RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Modifications are not allowed on this view';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_insert_update_delete
INSTEAD OF INSERT OR UPDATE OR DELETE ON ALL_WORKERS_ELAPSED
FOR EACH STATEMENT EXECUTE FUNCTION prevent_modifications();

CREATE OR REPLACE FUNCTION audit_robot_creation() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_robot (robot_id, created_at)
    VALUES (NEW.id, CURRENT_DATE);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_robot_creation
AFTER INSERT ON robots
FOR EACH ROW EXECUTE FUNCTION audit_robot_creation();

CREATE OR REPLACE FUNCTION check_factories_consistency() RETURNS TRIGGER AS $$
DECLARE
    nb_factories INT;
    nb_worker_tables INT;
BEGIN
    SELECT COUNT(*) INTO nb_factories FROM factories;
    SELECT COUNT(*) INTO nb_worker_tables FROM pg_tables WHERE tablename LIKE 'workers_factory_%';
    IF nb_factories != nb_worker_tables THEN
        RAISE EXCEPTION 'Inconsistency between factories and worker tables';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_modifying_robots_factories
BEFORE INSERT OR UPDATE OR DELETE ON ROBOTS_FACTORIES
FOR EACH STATEMENT EXECUTE FUNCTION check_factories_consistency();
