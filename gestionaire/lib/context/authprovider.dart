import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier{

  String _token ;
  String _userId;

  AuthNotifier():
      _userId ="",
      _token ="";

  void _login( String userId, String token){
    _userId = userId;
    _token = token; 
    notifyListeners();
  }

 void _logout(){ 
  _userId = "";
  _token ="";
  notifyListeners();
 }

 String get token =>  _token; 
 String get userId => _userId; 
 bool get isLogin => _token.isNotEmpty && _userId.isNotEmpty; 
}