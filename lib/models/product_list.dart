// ignore_for_file: prefer_final_fields, prefer_const_declarations

import 'dart:convert';
import 'dart:math';

import 'package:app_loja/data/DUMMY_DATA.dart';
import 'package:app_loja/models/produt.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-curso-e9b83-default-rtdb.firebaseio.com';
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  int get itemsCount {
    return _items.length;
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

  Future<void> addProduct(Product product) {
    final future = post(Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          "name": product.name,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }));

    return future.then((response) {
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
    });
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