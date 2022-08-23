import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/order_widget.dart';
import 'package:app_loja/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) {
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (context, i) => OrderWidget(order: orders.items[i]),
              ),
          ),
    );
  }
}
