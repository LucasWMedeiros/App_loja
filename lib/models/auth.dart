import 'dart:convert';

import 'package:app_loja/utils/api_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  
    static const _url = API_Key.url;
  Future<void> signup(String email ,String password) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email' : email,
        'password' : password,
        'returnSecureToken': true
      })
    );

    print(jsonDecode(response.body));
  }
}