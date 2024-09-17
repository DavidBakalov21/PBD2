import mysql.connector
from mysql.connector import Error
import consts
from faker import Faker
import random
HOST = '127.0.0.1'
USER = consts.USER
PASSWORD = consts.PASSWORD
DATABASE = 'Assignment2'


def create_connection():
    try:
        connection = mysql.connector.connect(
            host=HOST,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error: {e}")
    return None
fake = Faker()
connection = create_connection()
cursor = connection.cursor()
connection.start_transaction(isolation_level='READ UNCOMMITTED')
cursor.execute("SELECT surname FROM client")
print("cursor:"+str(cursor.fetchone()[0]))

# Insert 1,000,000 rows into opt_clients
print("insert clients")
client_insert_query = """
    INSERT INTO client (name, surname, email, phone, address)
    VALUES (%s, %s, %s, %s, %s)
"""

clients_data = [
    (fake.first_name(), fake.last_name(), fake.email(), fake.phone_number(), fake.address())
    for _ in range(100000)
]

cursor.executemany(client_insert_query, clients_data)
connection.commit()

print("Inserted into client.")


print("insert products")
product_insert_query = """
    INSERT INTO product (product_name, product_price, product_category, description)
    VALUES (%s, %s, %s, %s)
"""

# Sample categories for product_category
categories = ['food', 'furniture', 'clothes', 'hardware']

# Generate 100,000 products
products_data = [
    (fake.word(), random.randint(10, 5000), random.choice(categories), fake.text())
    for _ in range(100000)
]

cursor.executemany(product_insert_query, products_data)
connection.commit()
print("products inserted")



print("insert products")
product_insert_query = """
    INSERT INTO product (product_name, product_price, product_category, description)
    VALUES (%s, %s, %s, %s)
"""

# Sample categories for product_category
categories = ['food', 'furniture', 'clothes', 'hardware']

# Generate 100,000 products
products_data = [
    (fake.word(), random.randint(10, 5000), random.choice(categories), fake.text())
    for _ in range(100000)
]

cursor.executemany(product_insert_query, products_data)
connection.commit()
print("products inserted")

print("insert orders")
cursor.execute("SELECT product_id FROM product")
product_ids = [row[0] for row in cursor.fetchall()]

# Fetch all user_ids from the client table
cursor.execute("SELECT user_id FROM client")
user_ids = [row[0] for row in cursor.fetchall()]
order_insert_query = """
    INSERT INTO client_order (product_id, user_id)
    VALUES (%s, %s)
"""

# Generate 100,000 orders
orders_data = [
    (random.choice(product_ids), random.choice(user_ids))
    for _ in range(100000)
]

cursor.executemany(order_insert_query, orders_data)
connection.commit()


print("inserted orders")



cursor.close()
connection.close()