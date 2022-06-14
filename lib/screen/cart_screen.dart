// ignore_for_file: prefer_const_constructors

import 'package:app_loja/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
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
                  SizedBox(width: 10,),
                  Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'R\$${cart.totalAmount}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                ?.color),
                      )),
                      Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('COMPRAR'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Theme.of(context).primaryColor)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
