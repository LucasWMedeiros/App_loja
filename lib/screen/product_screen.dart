import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: ((context, index) => Text(products.items[index].name)),
        ),
      ),
    );
  }
}
