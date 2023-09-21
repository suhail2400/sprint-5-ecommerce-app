import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  const CartCard({required this.product, super.key});

  final Product product;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    var q = 1;
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(widget.product.image),
      ),
      title: Text(widget.product.name),
      subtitle: Text('\$' '${widget.product.price}'),
      trailing: Wrap(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () => setState(() {
                  if (q >= 0) {
                    q++;
                  }
                }),
                child: const Icon(Icons.add_circle),
              ),
              Text('$q'),
              InkWell(
                onTap: () => setState(() {
                  if (q > 0) {
                    q--;
                  }
                }),
                child: const Icon(Icons.remove_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
