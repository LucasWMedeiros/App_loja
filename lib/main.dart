// ignore_for_file: deprecated_member_use

import 'package:app_loja/providers/counter.dart';
import 'package:app_loja/screen/counter_screen.dart';
import 'package:app_loja/screen/products_detail_screen.dart';
import 'package:app_loja/screen/produtcs_overview_screen.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato'
      ),
      home: ProductsOverviewScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()
      },
    );
  }
}

