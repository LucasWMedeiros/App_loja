import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app_loja/models/produt.dart';

class ProductFormScreen extends StatefulWidget {
  ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
    print(newProduct.id);
    print(newProduct.name);
    print(newProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Builder(builder: (context) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (_name) {
                    final name = _name ?? '';
                    if(name.trim().isEmpty){
                      return 'Nome é obrigatório';
                    }
                    if(name.trim().length < 3){
                      return 'Nome precisa no minimo de 3 letras';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Valor'),
                  focusNode: _priceFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (description) =>
                      _formData['description'] = description ?? '',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Url da imagem'),
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onSaved: (imageUrl) =>
                            _formData['imageUrl'] = imageUrl ?? '',
                        onFieldSubmitted: (_) => _submitForm(),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Informe a Url')
                          : FittedBox(
                              // ignore: sort_child_properties_last
                              child: Image.network(_imageUrlController.text, width: 90, height: 90,),
                              fit: BoxFit.cover,
                              
                            ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
