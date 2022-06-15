import 'package:app_loja/models/cart_item.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('${cartItem.price}'),
            ),),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total R\$${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}X'),
        ),
      ),
    );
  }
}
