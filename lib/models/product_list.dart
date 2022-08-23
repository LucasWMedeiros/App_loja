// ignore_for_file: prefer_final_fields, prefer_const_declarations

import 'dart:convert';
import 'dart:math';

import 'package:app_loja/models/produt.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ProductList with ChangeNotifier {
  final _url =
      'https://shop-curso-e9b83-default-rtdb.firebaseio.com/products.json';
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    final response = await get(Uri.parse(_url));
    if(response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> SaveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await post(Uri.parse(_url),
        body: jsonEncode({
          "name": product.name,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }));
    final id = jsonDecode(response.body)['name'];
    print(id);
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;

//   List<Product> get  items {
//     if(_showFavoriteOnly){
//       return _items.where((prod) => prod.isFavorite).toList();
//     }

//   return [..._items];

//   } 

//   void showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll(){
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }