import 'package:app_loja/models/produt.dart';
import 'package:flutter/material.dart';

class ProducItem extends StatelessWidget {
  final Product product;
  const ProducItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: (){},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
