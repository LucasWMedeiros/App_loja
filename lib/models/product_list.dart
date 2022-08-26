// ignore_for_file: prefer_final_fields, prefer_const_declarations

import 'dart:convert';
import 'dart:math';

import 'package:app_loja/exceptions/http_exception.dart';
import 'package:app_loja/models/produt.dart';
import 'package:app_loja/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = Constants.PRODUCT_BASE_URL;
  List<Product> _items = [];
  final String _userId;

  String _token;

  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('$_baseUrl.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
        Uri.parse('${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token'));

    Map<String, dynamic> favData = 
    favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite
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
    final response = await http.post(Uri.parse('$_baseUrl.json?auth=$_token'),
        body: jsonEncode({
          "name": product.name,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
        }));
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(Uri.parse('$_baseUrl/${product.id}.json?auth=$_token'),
          body: jsonEncode({
            "name": product.name,
            "price": product.price,
            "description": product.description,
            "imageUrl": product.imageUrl,
          }));

      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http
          .delete(Uri.parse('$_baseUrl/${product.id}.json?auth=$_token'));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possivel excluir o produto.',
          statusCode: response.statusCode,
        );
      }
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