import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Guide to using cloud firestore with flutter: https://firebase.flutter.dev/docs/firestore/usage/

import 'order_sub.dart';


// This file includes code for checking the firebase database that stores whether subs are on sale or not.


class GetSaleStatus extends StatelessWidget {
  final String documentId = 'SaleDocument';

  @override
  Widget build(BuildContext context)  {

    CollectionReference users = FirebaseFirestore.instance.collection('SaleCollection');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Please check your internet connection.");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (data['is_sale']) {
            return OutlinedButton(
              child: new Text('Yes! Let\'s order!', //'Preciso de ajuda',
                  style: new TextStyle(fontSize: 16.0, color: Color(0xFF3C7D2C))),
              onPressed: () {
                orderSub();
                //setState(() {});
              },
            );
          } else {
            return OutlinedButton(
              child: new Text('No... but I want to order one anyway.', //'Preciso de ajuda',
              style: new TextStyle(fontSize: 16.0, color: Color(0xFF3C7D2C))),
              onPressed: () {
                orderSub();
                //setState(() {});
              },
            );
          }
        }
        // display a circular loading icon while unfinished
        return CircularProgressIndicator();
      },
    );
  }
}
