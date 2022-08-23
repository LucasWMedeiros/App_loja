import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/product_item.dart';
import 'package:app_loja/models/product_list.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: ((context, index) => Column(
                  children: [
                    ProducItem(product: products.items[index]),
                    Divider()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
