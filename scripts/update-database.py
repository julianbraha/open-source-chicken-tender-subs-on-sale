# "get started with cloud firebase" https://firebase.google.com/docs/firestore/quickstart#web_2

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

import os

credential_path = "chicken-tender-subs-on-sale-v2-firebase-adminsdk-rl77s-af45b31513.json"

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path

cred = credentials.Certificate(credential_path)

# Use the application default credentials
cred = credentials.ApplicationDefault()
firebase_admin.initialize_app(cred)

db = firestore.client()

# TESTING WRITE
doc_ref = db.collection(u'SaleCollection').document(u'SaleDocument')
doc_ref.set({
    u'is_sale': True
})

# TESTING READ:
users_ref = db.collection(u'SaleCollection')
docs = users_ref.stream()

for doc in docs:
    print(f'{doc.id} => {doc.to_dict()}')
