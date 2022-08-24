import 'dart:convert';

import 'package:app_loja/exceptions/auth_exception.dart';
import 'package:app_loja/utils/api_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  
    

  Future<void> _autenticate(String email, String password, String urlFragment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${API_Key.apiKey}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email' : email,
        'password' : password,
        'returnSecureToken': true
      })
    );

    final body = jsonDecode(response.body);
    if(body['error'] != null){
      throw AuthException(body['error']['message']);
    }
  }

  Future<void> signup(String email ,String password) async {
    return _autenticate(email, password, 'signUp');
  }
  Future<void> login(String email ,String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}