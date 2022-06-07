import 'package:app_loja/models/produt.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {

  ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
        centerTitle: true,
      ),
    );
  }
}
