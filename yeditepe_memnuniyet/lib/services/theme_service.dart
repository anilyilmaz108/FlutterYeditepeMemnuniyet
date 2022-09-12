import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier{


  bool _isLight = true;

  bool get isLight => _isLight;
  ThemeData get selectedTheme => _isLight ? ThemeData.light() : ThemeData.dark();

  static SharedPreferences? _sharedPreferences;

  void switchButton(bool selected){
    _isLight = selected;
    saveToSharedPreferences(selected);
    notifyListeners();
  }

  Future<void>createSharedPreferencesObject()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveToSharedPreferences(bool value){
    _sharedPreferences?.setBool("color", value);
  }

  void loadFromSharedPreferences(){
    _isLight = _sharedPreferences?.getBool("color")??true;
  }


  }