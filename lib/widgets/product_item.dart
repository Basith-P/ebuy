import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/routes.dart' as route;
import '../provider/model_product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imgURL;

  const ProductItem({
    Key? key,
    // required this.id,
    // required this.title,
    // required this.imgURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route.productDetailsPage, arguments: product.id),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.white,
            child: GridTile(
              child: Image.network(product.imgURL),
              footer: GridTileBar(
                backgroundColor: Colors.white.withOpacity(.95),
                title: Text(
                  product.title,
                  style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                trailing: IconButton(
                  onPressed: () {
                    product.toggleFavStatus();
                  },
                  icon: Icon(
                    product.isFav ? Icons.favorite_outlined : Icons.favorite_outline_rounded,
                    color: product.isFav ? Colors.deepOrange : Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
