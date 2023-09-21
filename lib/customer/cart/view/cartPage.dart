import 'package:ecomm/customer/myProducts.dart';
import 'package:ecomm/widgets/cartCard.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
        ),
        body: ListView.builder(
            itemCount: MyProducts.cartProducts.length,
            itemBuilder: (context, index) {
              final product = MyProducts.cartProducts[index];
              return CartCard(
                product: product,
              );
            }));
  }
}
