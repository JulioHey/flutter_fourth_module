import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        Uri.parse('https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyBCT3FQjsIRT59Jp1Oh-0WhckXImtlE6sk');
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
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  void logout() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry =_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpiry),
      logout
    );
  }
}

// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;

// import '../models/http_exception.dart';

// class AuthProvider extends ChangeNotifier {
//   String _token;
//   DateTime _expiryDate;
//   String _userId;

//   bool get isAuth {
//     return token != null;
//   }

//   String get token {
//     if (
//       _expiryDate != null && 
//       _expiryDate.isAfter(DateTime.now()) &&
//       _token != null 
//     ) {
//       return _token;
//     }
//     return null;
//   }

//   Future<void> signup(String email, String password) async {
//     await _authenticate(email, password, 'signUp');
//   }

//   Future<void> login(String email, String password) async {
//     await _authenticate(email, password, 'signInWithPassword');

//     // final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBCT3FQjsIRT59Jp1Oh-0WhckXImtlE6sk');
    
//     // Map<String, String> headers = {
//     //     'Content-Type': 'application/json;charset=UTF-8',
//     //     'Charset': 'utf-8'
//     // };

//     // final body = json.encode({
//     //   "email": email,
//     //   "password": password,
//     //   "returnSecureToken": true,
//     // });

//     // try {
//     //   final response = await http.post(
//     //     url,
//     //     body: body,
//     //     headers: headers
//     //   ).timeout(Duration(seconds: 5));

//     //   final responseData = await json.decode(response.body);

//     //   if (responseData['error'] != null) {
//     //     throw HttpException(responseData['error']['message']);
//     //   }

//     //   _token = await responseData['idToken'];
//     //   _userId = await responseData['localId'];

//     //   _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiryIn'])));
//     //   notifyListeners();
//     // } catch(error) {
//     //   print(error);
//     //   throw error;
//     // }
//   }

//   Future<void> _authenticate(String email, String password, String method) async {
//     final url = Uri.parse('https://www.googleapis.com/identitytoolkit/v3/relyingparty/$method?key=AIzaSyBCT3FQjsIRT59Jp1Oh-0WhckXImtlE6sk');

//     // final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyBCT3FQjsIRT59Jp1Oh-0WhckXImtlE6sk');
//     // Map<String, String> headers = {
//     //     'Content-Type': 'application/json;charset=UTF-8',
//     //     'Charset': 'utf-8'
//     // };

//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             'returnSecureToken': true,
//           },
//         ),
//         // headers: headers,
//       ).timeout(Duration(seconds: 3));

//       final responseData = await json.decode(response.body);

//       if (await responseData['error'] != null) {
//         throw HttpException(await responseData['error']['message']);
//       }

//       _token = await responseData['idToken'];
//       _userId = await responseData['localId'];

//       _expiryDate = DateTime.now().add(Duration(seconds: int.parse(await responseData['expiryIn'])));
//       notifyListeners();
//     } catch(error) {
//       print(error);
//       throw error;
//     }
//   }

// }