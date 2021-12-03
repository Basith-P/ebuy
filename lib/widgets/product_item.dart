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
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: GridTile(
            child: Image.network(
              imgURL,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(title),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline_rounded),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
