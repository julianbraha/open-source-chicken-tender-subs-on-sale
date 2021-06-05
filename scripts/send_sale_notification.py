import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import messaging
import os

# notifies all users with the app installed.
# function assumes firebase has already been initialized.
def notify():
    db = firestore.client()

    # "The topic name can be optionally prefixed with "/topics/"."
    topic = 'Sales'

    # this is the actual notification that users receive:
    message = messaging.Message(
        notification=messaging.Notification(
            title='Chicken tender subs are now on sale!',
        ),
        topic=topic,
    )

    # Send a message to the devices subscribed to the provided topic.
    response = messaging.send(message)

    # debugging:
    #print('Successfully sent message:', response)
