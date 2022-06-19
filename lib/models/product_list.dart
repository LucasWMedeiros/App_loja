// ignore_for_file: prefer_final_fields

import 'package:app_loja/data/DUMMY_DATA.dart';
import 'package:app_loja/models/produt.dart';
import 'package:flutter/cupertino.dart';

class ProductList with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get  items => [..._items];
  List<Product> get  favoriteItems => _items.where((prod) => prod.isFavorite).toList();
  int get itemsCount {
    return _items.length;
  }


  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
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