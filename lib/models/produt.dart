import 'dart:convert';

import 'package:app_loja/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    _toggleFavorite();
    final response = await http.patch(
        Uri.parse('${Constants.PRODUCT_BASE_URL}/$id.json?auth=$token'),
        body: jsonEncode({"isFavorite": isFavorite}));

    if (response.statusCode >= 400) {
      _toggleFavorite();
    }
  }
}
