import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgURL;

  const ProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imgURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(imgURL),
        footer: GridTileBar(
          backgroundColor: Colors.teal[900],
          title: Text(title),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded),
          ),
        ),
      ),
    );
  }
}
