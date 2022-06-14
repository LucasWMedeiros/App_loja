// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:app_loja/components/badge.dart';
import 'package:app_loja/components/product_grid.dart';
import 'package:app_loja/models/cart.dart';
import 'package:app_loja/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectdValue) {
              setState(() {
                if (selectdValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.shopping_cart),
              ),
            builder: ((context, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!
            )
          )),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
