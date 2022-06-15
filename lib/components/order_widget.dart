import 'package:app_loja/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({
    Key? key,
    required this.order
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('R\$${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(order.date)
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: (){},
        ),
      ),
    );
  }
}