// ignore_for_file: prefer_const_constructors

import 'package:app_loja/components/cart_item_widget.dart';
import 'package:app_loja/models/cart.dart';
import 'package:app_loja/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final itens = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'R\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                ?.color),
                      )),
                  Spacer(),
                  cartButton(cart: cart)
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: itens.length,
            itemBuilder: ((context, index) =>
                CartItemWidget(cartItem: itens[index])),
          ))
        ],
      ),
    );
  }
}

class cartButton extends StatefulWidget {
  const cartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<cartButton> createState() => _cartButtonState();
}

class _cartButtonState extends State<cartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
      onPressed: widget.cart.itemsCount == 0
          ? null
          : () async {
            setState(() => _isLoading = true);
              await Provider.of<OrderList>(
                context,
                listen: false,
              ).addOrder(widget.cart);

              setState(() => _isLoading = false);
              widget.cart.clear();
            },
      child: Text('COMPRAR'),
      style: TextButton.styleFrom(
          textStyle:
              TextStyle(color: Theme.of(context).primaryColor)),
    );
  }
}
