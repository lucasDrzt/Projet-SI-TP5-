import socketserver
import json
import os
import psycopg2
from dotenv import load_dotenv

#region querys

QUANTITY_STORE = (
    "SELECT quantity FROM stock Where factory_id = %s"
)
QUANTITY_PRODUCT = (
    "SELECT quantity FROM stock WHERE id_stock = %s"
)
QUANTITY_ALL = (
    "SELECT * FROM stock"
)

#endregion

def get_quantity_store(product_id):
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY, (product_id))
        quantity = cursor.fetchone()

    return {'quantity': quantity}

def get_quantity_all():
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY_ALL)
        quantity = cursor.fetchall()

    return {'quantity': quantity}

def get_quantity_product(product_id):
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY_PRODUCT, (product_id))
        quantity = cursor.fetchone()

    return {'quantity': quantity}

load_dotenv()
url = os.getenv('DATABASE_URL')
connection = psycopg2.connect(url)

class Server(socketserver.BaseRequestHandler):

    def handle(self):
        self.data = self.request.recv(1024).strip().decode('utf-8')
        print("Received from {}:".format(self.client_address[0]))
        
        response = ""
        if self.data == "1" or self.data == "2":
            response = json.dumps(get_quantity_store(int(self.data)))
        elif self.data.startswith("global"):
            response = json.dumps(get_quantity_all())
        

        self.request.sendall(response.encode('utf-8'))

if __name__ == "__main__":
    HOST, PORT = "localhost", 9999
    server = socketserver.TCPServer((HOST, PORT), Server)
    server.serve_forever()































load_dotenv()
url = os.getenv('DATABASE_URL')
port = os.getenv('PORT')
store_id = os.getenv('STORE_ID')
product_id = os.getenv('PRODUCT_ID')
quantity = os.getenv('QUANTITY')

QUANTITY = (
    "SELECT quantity FROM inventory WHERE product_id = %s"
)

QUANTITY_STORE = (
    "SELECT quantity FROM inventory WHERE product_id = %s AND store_id = %s"
)

TEST = (
    "SELECT * FROM client"

)

connection = psycopg2.connect(url)

def get_quantity():
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY, (product_id))
        quantity = cursor.fetchone()

    return {'quantity': quantity}

def get_quantity_store():
    with connection.cursor() as cursor:
        cursor.execute(QUANTITY_STORE, (product_id, store_id))
        quantity = cursor.fetchone()

    return {'quantity': quantity}

def test():
    with connection.cursor() as cursor:
        cursor.execute(TEST)
        quantity = cursor.fetchone()

    return {'quantity': quantity}

if __name__ == '__main__':
    print(get_quantity())
    print(get_quantity_store())
    print(test())
