import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});
  final QueryDocumentSnapshot<Map<String, dynamic>> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(
            height: 130,
            width: 130,
            child: Image.network(
              product['image'][0].toString(),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            product['name'].toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            product['category'].toString(),
            style: const TextStyle(fontSize: 14, color: Colors.red),
          ),
          Text(
            r'$ ' '${product['price'].toString()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
