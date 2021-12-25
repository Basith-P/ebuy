import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Rs. ${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('dd-MM-yyyy  hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded),
            ),
          ),
          if (_expanded)
            SizedBox(
              height: min(widget.order.products.length * 22.0 + 10, 150),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 15),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: widget.order.products
                      .map(
                        (e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                            Text('${e.quantity}x ${e.price}'),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
