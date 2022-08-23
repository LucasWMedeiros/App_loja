// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:app_loja/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:app_loja/models/produt.dart';
import 'package:provider/provider.dart';

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

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
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

  bool isValidImageUrl(String url) {
    bool isValidUrl =
        url.trim().isEmpty /*Uri.tryParse(url)?.hasAbsolutePath ?? false*/;
    return isValidUrl;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).SaveProduct(_formData);
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Builder(builder: (context) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
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
                          if (name.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          if (name.trim().length < 3) {
                            return 'Nome precisa no minimo de 3 letras';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: const InputDecoration(labelText: 'Valor'),
                        focusNode: _priceFocus,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0'),
                        validator: (_price) {
                          final priceString = _price ?? '-1';
                          final price = double.tryParse(priceString) ?? -1;

                          if (price <= 0) {
                            return 'Informe um preço válido.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'Descrição'),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onSaved: (description) =>
                            _formData['description'] = description ?? '',
                        validator: (_description) {
                          final description = _description ?? '';
                          if (description.trim().isEmpty) {
                            return 'É obrigatório uma descrição';
                          }
                          if (description.trim().length < 10) {
                            return 'Descrição precisa de no minimo 10 letras';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Url da imagem'),
                              textInputAction: TextInputAction.done,
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              validator: (_imageUrl) {
                                final imageUrl = _imageUrl ?? '';
                                if (isValidImageUrl(imageUrl)) {
                                  return 'Informe uma Url valida.';
                                }
                                return null;
                              },
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
                                    child: Image.network(
                                      _imageUrlController.text,
                                      width: 90,
                                      height: 90,
                                    ),
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
