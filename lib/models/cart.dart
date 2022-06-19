import 'dart:math';

import 'package:app_loja/models/cart_item.dart';
import 'package:app_loja/models/produt.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) { 
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingItem) => CartItem(
                id: existingItem.id,
                productId: existingItem.productId,
                name: existingItem.name,
                quantity: existingItem.quantity + 1,
                price: existingItem.price,
              ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: Random().nextDouble().toString(),
                productId: product.id,
                name: product.name,
                quantity: 1,
                price: product.price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }
  
  void removeSingleItem(String productid){
    if(!_items.containsKey(productid)){
      return;
    }
    if(_items[productid]?.quantity == 1){
      _items.remove(productid);
    } else {
       _items.update(
          productid,
          (existingItem) => CartItem(
                id: existingItem.id,
                productId: existingItem.productId,
                name: existingItem.name,
                quantity: existingItem.quantity - 1,
                price: existingItem.price,
              ));
    }
    notifyListeners();
  }
  void clear() {
    _items = {};
    notifyListeners();
  }
}
