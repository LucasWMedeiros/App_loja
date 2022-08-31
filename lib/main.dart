// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:app_loja/custom_rout.dart';
import 'package:app_loja/models/auth.dart';
import 'package:app_loja/models/cart.dart';
import 'package:app_loja/models/order.dart';
import 'package:app_loja/models/order_list.dart';
import 'package:app_loja/models/product_list.dart';
import 'package:app_loja/screen/about_screen.dart';
import 'package:app_loja/screen/auth_or_home_screen.dart';
import 'package:app_loja/screen/auth_screen.dart';
import 'package:app_loja/screen/cart_screen.dart';
import 'package:app_loja/screen/orders_screen.dart';
import 'package:app_loja/screen/product_form_screen.dart';
import 'package:app_loja/screen/product_screen.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          )
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => AuthOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.ORDERS: (context) => OrdersScreen(),
          AppRoutes.PRODUCTS: (context) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormScreen(),
          AppRoutes.ABOUT: (context) => AboutScreen()
        },
      ),
    );
  }
}
