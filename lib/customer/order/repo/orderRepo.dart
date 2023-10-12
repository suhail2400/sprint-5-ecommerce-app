import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OrderRepo {
  Future<String> placeOrder(
      {required final String userId, required BuildContext context}) async {
    final uuid = Uuid();
    final oId = uuid.v4();
    final CollectionReference orderItems =
        FirebaseFirestore.instance.collection('orderItems');
    try {
      await orderItems.doc(oId).set({
        'userId': userId,
        'orderId': oId,
        'status': 'pending',
        'productIds': {},
        'quantity': {},
        'subtotal': {},
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
    return oId;
  }
}
