import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductRepo {
  final auth = FirebaseAuth.instance;
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('productCollection');
  Future<void> createProduct(
    String name,
    String category,
    List<XFile> images,
    String description,
    double price,
    int quantity,
    BuildContext context,
  ) async {
    final uuid = Uuid();
    final pId = uuid.v4();
    List<String>? imagePaths = [];
    try {
      for (final element in images) {
        final reference =
            FirebaseStorage.instance.ref().child('images').child(element.name);
        final file = File(element.path);
        await reference.putFile(file);
        final imageUrl = await reference.getDownloadURL();
        imagePaths.add(imageUrl);
      }
      await productRef.doc(pId).set({
        'name': name,
        'category': category,
        'image': imagePaths,
        'description': description,
        'price': price,
        'quantity': quantity,
        'productId': pId,
        'userId': auth.currentUser!.uid,
      });
    } on FirebaseException catch (e) {
      // throw Exception('Something went wrong');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
