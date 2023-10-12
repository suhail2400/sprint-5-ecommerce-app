import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/customer/cart/view/cartPage.dart';
import 'package:ecomm/customer/detailsScreen.dart/view/detailsScreen.dart';
import 'package:ecomm/widgets/productCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerHomePage extends StatelessWidget {
  CustomerHomePage({super.key});

  final auth = FirebaseAuth.instance;
  final productRef = FirebaseFirestore.instance.collection('productCollection');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            child: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: productRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final productData = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 100 / 140,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: productData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: productData[index],
                        ),
                      ),
                    ),
                    child: ProductCard(
                      product: productData[index],
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
