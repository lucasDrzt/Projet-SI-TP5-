import logging
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from config import Config
from datetime import datetime

# Configuration du logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s: %(message)s')

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

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
    factory = db.relationship('Factory', backref='employees')

# Créer toutes les tables avant la première requête
@app.before_request
def create_tables():
    db.create_all()

@app.route('/')
def index():
    try:
        employees = Employee.query.all()
        return render_template('index.html', employees=employees)
    except UnicodeDecodeError as e:
        logging.error(f"Unicode decode error: {e}")
        return "An error occurred while processing your request."
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
        return "An error occurred while processing your request."

if __name__ == '__main__':
    app.run(debug=True)
