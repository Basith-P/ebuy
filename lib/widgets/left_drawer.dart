import 'package:flutter/material.dart';

import '../config/routes.dart' as route;

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello John'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(context, route.productOverviewPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, route.ordersPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Manage your products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, route.userProductsPage);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
