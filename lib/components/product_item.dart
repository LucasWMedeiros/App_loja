// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:app_loja/models/produt.dart';
import 'package:app_loja/screen/products_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product))
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: const Icon(Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
