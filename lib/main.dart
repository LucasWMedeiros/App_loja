// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:app_loja/models/cart.dart';
import 'package:app_loja/models/product_list.dart';
import 'package:app_loja/screen/cart_screen.dart';
import 'package:app_loja/screen/products_detail_screen.dart';
import 'package:app_loja/screen/produtcs_overview_screen.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductsOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen()
        },
      ),
    );
  }
}

