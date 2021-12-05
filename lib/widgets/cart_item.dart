import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String prodId;
  final String title;
  final String imgUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.prodId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        child: const Icon(
          Icons.delete_outlined,
          color: Colors.white,
          size: 32,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.red[400],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => Provider.of<Cart>(context, listen: false).removeItem(prodId),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: SizedBox(
            width: 40,
            child: Image.network(imgUrl),
          ),
          title: Text(title),
          subtitle: Text('Rs. $price    ${quantity}x'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total'),
              Text('Rs. ${(quantity * price).toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
