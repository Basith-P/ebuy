import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: ListTile(
        leading: Container(
          width: 40,
          child: Image.network(imgUrl),
        ),
        title: Text(title),
        subtitle: Text('Rs. $price    $quantity Pcs'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Total'),
            Text('Rs. ${(quantity * price).toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
