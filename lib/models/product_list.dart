// ignore_for_file: prefer_final_fields

import 'package:app_loja/data/DUMMY_DATA.dart';
import 'package:app_loja/models/produt.dart';
import 'package:flutter/cupertino.dart';

class ProductList with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get  items => [..._items];

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }
}