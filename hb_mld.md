
# Modèle Logique des Données (MLD)

## Tables et Attributs

### Factories
- ID_Factory (PK)
- Name

### Employees
- ID_employee (PK)
- first_name
- last_name
- age
- start_date
- end_date
- factory_ID (FK)

### Deliveries
- id_robot (PK)
- model_name
- factory_ID (FK)
- supplier_ID (FK)
- create_at

### Stock
- id_robot (FK)
- id_stock (PK)
- quantity

### audit_robot
- id_audit (PK)
- robot_id (FK)
- create_at

### Suppliers
- ID_suppliers (PK)
- Name

## Relations

- Factories(ID_Factory) <-> Employees(factory_ID)
- Factories(ID_Factory) <-> Deliveries(factory_ID)
- Deliveries(id_robot) <-> Stock(id_robot)
- Deliveries(id_robot) <-> audit_robot(robot_id)
- Suppliers(ID_suppliers) <-> Deliveries(supplier_ID)

![Modèle Logique des Données](hb_mld.png)
