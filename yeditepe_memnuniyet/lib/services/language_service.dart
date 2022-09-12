import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeditepe_memnuniyet/constants.dart';


class LanguageService with ChangeNotifier{

  bool _isTurkish = true;
  bool get isTurkish => _isTurkish;
  Locale get Selected => _isTurkish ? AppConstant.TR_LOCALE : AppConstant.EN_LOCALE;



  void toggleStatus(bool selected){
    _isTurkish = selected;
    saveToSharedPreferences(selected);
    notifyListeners();
  }




  static SharedPreferences? _sharedPreferences;
  Future<void>createSharedPreferencesObject()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveToSharedPreferences(bool value){
    _sharedPreferences?.setBool("language", value);
  }

  void loadFromSharedPreferences(){
    _isTurkish = _sharedPreferences?.getBool("language")??true;
  }

}