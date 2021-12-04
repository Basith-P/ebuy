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
    final product = Provider.of<Product>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route.productDetailsPage, arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product.imgURL,
                  ),
                ),
              ),
              Container(
                color: Colors.deepOrange.withOpacity(.1),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      'Rs. ' + product.price.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              product.toggleFavStatus();
                            },
                            icon: Icon(
                              product.isFav
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_outline_rounded,
                              // color: product.isFav ? Colors.deepOrange : Colors.grey[800],
                              color: Colors.deepOrange.withOpacity(.8),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.deepOrange.withOpacity(.8),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
GridTile(
              child: Image.network(product.imgURL),
              footer: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white.withOpacity(.95),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                      ],
                    ),
                    Column(
                      children: [
                        
                      ],
                    )
                  ],
                ),
              ),
            ),
*/