# this script should be run once per day.

# price of a sub usually. must change this value manually whenever publix changes the price.
# TODO: automate this process, by searching for word "sale" during a sale, and update the price standard when that word doesn't exist.
price_standard = 6.09

from check_price import get_price
from send_sale_notification import notify

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os

def initialize_database():
    credential_path = 'MY_FIREBASE_CREDENTIALS.json'
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path
    cred = credentials.Certificate(credential_path)
    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    return db


def database_read():
    db = initialize_database
    users_ref = db.collection('SaleCollection')
    docs = users_ref.stream()
    database_sale_status = False
    for doc in docs:
        print(f"{doc.id} => {doc.to_dict()}")
        database_sale_status = doc.to_dict()
    else:
        return database_sale_status


def database_write(sale_flag):
    db = initialize_database
    doc_ref = db.collection('SaleCollection').document('SaleDocument')
    doc_ref.set({'is_sale': sale_flag})


initialize_database()

price_today = get_price()
was_sale_yesterday = database_read()

# update database then notify users when sale begins
if price_today < price_standard and not was_sale_yesterday:
    database_write(True)
    notify()

# update database when sale ends
elif price_today > price_standard and was_sale_yesterday:
    database_write(False)

# don't do anything if today isn't the beginning or the end of the sale
else:
    pass

print(was_sale_yesterday)
