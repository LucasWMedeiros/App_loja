// ignore_for_file: prefer_const_constructors

import 'package:app_loja/components/product_grid.dart';
import 'package:flutter/material.dart';

enum FilterOptions {
  Favorite,
  All
}

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
          PopupMenuButton(itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('Somente Favoritos'),
              value: FilterOptions.Favorite,
              ),
            PopupMenuItem(
              child: Text('Todos'),
              value: FilterOptions.All,
              )
          ],
          onSelected: (FilterOptions selectdValue) {
            setState(() {
            if(selectdValue == FilterOptions.Favorite){
              _showFavoriteOnly = true;
            } else {
              _showFavoriteOnly = false;
            }
            });
          },
          )
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}


