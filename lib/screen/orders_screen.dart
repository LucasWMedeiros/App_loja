import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/order_widget.dart';
import 'package:app_loja/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, i) => OrderWidget(order: orders.items[i]),
      ),
    );
  }
}
