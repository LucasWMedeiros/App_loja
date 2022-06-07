// ignore_for_file: prefer_const_constructors

import 'package:app_loja/providers/counter.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo contador'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(CounterProvider.of(context)?.state.value.toString() ?? '0'),
          IconButton(
            onPressed: () {
              setState(() {
              CounterProvider.of(context)?.state.inc();
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: (){
              setState(() {
              CounterProvider.of(context)?.state.dec();
              });
            },
            icon: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
