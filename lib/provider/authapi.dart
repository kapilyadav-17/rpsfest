
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{
  late String userid;
  late String expirydate;
  late String token;
//AIzaSyDeW1URz_JCCv1giba7sJY8OkO4rWpJXCQ
  Future<void> SisgnUp(String phone ,String pass) async{
    final url =Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDeW1URz_JCCv1giba7sJY8OkO4rWpJXCQ');
    final response = await http.post(url,body: json.encode({
      'email': phone,
      'password':pass,
      'returnSecureToken': true,
    }));
    print(json.decode(response.body));
  }
  Future<void> authenticate(String email,String password,String url) async{

  }
  Future<void> signUp(String email,String password) async{
    return authenticate(email, password, '');
  }
  Future<void> loginIn(String email,String password) async{
    return authenticate(email, password, '');
  }

}