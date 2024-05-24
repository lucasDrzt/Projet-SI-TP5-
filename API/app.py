#make a web api in python to check quantity of a product on different stores
from flask import Flask, request, jsonify
import requests
import json
import os
import psycopg2
from dotenv import load_dotenv

#region Querys
QUANTITY = (
    "SELECT quantity FROM inventory WHERE product_id = %s"
)

QUANTITY_STORE = (
    "SELECT quantity FROM inventory WHERE product_id = %s AND store_id = %s"
)

#endregion

load_dotenv()
app = Flask(__name__)
url = os.getenv('DATABASE_URL')
connection = psycopg2.connect(url)

@app.get('/api/quantity')
def quantity():
    return "Hello World"

@app.get('/api/quantity/store/{store_id}')
def quantity_store(store_id):
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY_STORE, (store_id))
        quantity = cursor.fetchone()

    return {'quantity': quantity}

if __name__ == '__main__':
    app.run(debug=True)
