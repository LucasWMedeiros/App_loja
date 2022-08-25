import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem Vindo Usuario'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}