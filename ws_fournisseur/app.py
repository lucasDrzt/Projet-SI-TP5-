import logging
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from config import Config
from datetime import datetime, timedelta

# Configuration du logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s: %(message)s')

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

class Supplier(db.Model):
    __tablename__ = 'suppliers'
    id_supplier = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

class Factory(db.Model):
    __tablename__ = 'factories'
    id_factory = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

class Employee(db.Model):
    __tablename__ = 'employees'
    id_employee = db.Column(db.Integer, primary_key=True)
    firstname = db.Column(db.String(50))
    lastname = db.Column(db.String(50))
    age = db.Column(db.Integer)
    start_date = db.Column(db.Date)
    end_date = db.Column(db.Date)
    factory_id = db.Column(db.Integer, db.ForeignKey('factories.id_factory'), nullable=False)

class Delivery(db.Model):
    __tablename__ = 'deliveries'
    id_delivery = db.Column(db.Integer, primary_key=True)
    supplier_id = db.Column(db.Integer, db.ForeignKey('suppliers.id_supplier'), nullable=False)
    factory_id = db.Column(db.Integer, db.ForeignKey('factories.id_factory'), nullable=False)
    delivery_date = db.Column(db.Date)
    quantity = db.Column(db.Integer)
    received_by = db.Column(db.Integer, db.ForeignKey('employees.id_employee'), nullable=False)
    supplier = db.relationship('Supplier', backref='deliveries')
    factory = db.relationship('Factory', backref='deliveries')
    received_by_employee = db.relationship('Employee', backref='received_deliveries')

# Créer toutes les tables avant la première requête
@app.before_request
def create_tables():
    db.create_all()

@app.route('/')
def index():
    try:
        ten_days_ago = datetime.now() - timedelta(days=10)
        deliveries = Delivery.query.filter(Delivery.delivery_date >= ten_days_ago).all()
        return render_template('index.html', deliveries=deliveries)
    except UnicodeDecodeError as e:
        logging.error(f"Unicode decode error: {e}")
        return "An error occurred while processing your request."
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
        return "An error occurred while processing your request."

if __name__ == '__main__':
    app.run(debug=True)
