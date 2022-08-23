import 'package:app_loja/exceptions/http_exception.dart';
import 'package:app_loja/models/product_list.dart';
import 'package:app_loja/models/produt.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducItem extends StatelessWidget {
  final Product product;
  const ProducItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Exclusão de Produto'),
                    content: const Text('Tem certeza que deseja excluir?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Não'),
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () => Navigator.of(context).pop()
                  )]
                  ),
                ).then((value) async {
                          try {
                            await Provider.of<ProductList>(
                              context,
                              listen: false,
                            ).removeProduct(product);
                          } on HttpException catch (error) {
                            msg.showSnackBar(SnackBar(
                              content: Text(error.toString()),
                            ),
                      );
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
