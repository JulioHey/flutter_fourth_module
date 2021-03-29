import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<void> singInWithPassword(String email, String password) async {
    await _authenticate(email, password, "signInWithPassword");
  }

  Future<void> _authenticate(String email, String password, String method) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyBCT3FQjsIRT59Jp1Oh-0WhckXImtlE6sk');
    Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
        headers: headers,
      ).timeout(Duration(seconds: 3));

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

    } catch(error) {
      throw error;
    }
  }

}