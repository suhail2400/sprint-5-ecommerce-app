import 'package:ecomm/seller/addProduct/view/addProduct.dart';
import 'package:flutter/material.dart';

class SellerHomePage extends StatelessWidget {
  const SellerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            ),
            leading: const Icon(Icons.add_box),
            title: const Text('Add Product'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
