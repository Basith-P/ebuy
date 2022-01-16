import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/routes.dart' as route;
import '../provider/product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  const UserProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 96,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                route.editProductPage,
                arguments: id,
              ),
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await context.read<Products>().deleteProd(id);
                } catch (e) {
                  scaffoldMessenger.hideCurrentSnackBar();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Couldn\'t delete the item!'),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.delete_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
