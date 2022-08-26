import 'package:app_loja/components/app_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Container(
        child: const Center(
          child: Text('Essa seção existe para informar sobre o que é o app'),
        ),
      ),
    );
  }
}