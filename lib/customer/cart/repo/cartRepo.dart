import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartRepo {
  Future<void> addToCart(
      {required final String userId,
      required final String productId,
      required BuildContext context}) async {
    final uuid = Uuid();
    final cId = uuid.v4();
    final auth = FirebaseAuth.instance;
    final CollectionReference cartItems =
        FirebaseFirestore.instance.collection('cartItems');
    int quantity = 1;
    try {
      await cartItems.doc(cId).set({
        'userId': userId,
        'cartId': cId,
        'productId': productId,
        'quantity': quantity,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}
