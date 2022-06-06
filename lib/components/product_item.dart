// ignore_for_file: sort_child_properties_last

import 'package:app_loja/models/produt.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product? product;

  const ProductItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(product!.imageUrl!,
        fit: BoxFit.cover,),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){},
          ),
          title: Text(product!.title!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}