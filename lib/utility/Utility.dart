import 'package:flutter/cupertino.dart';

class Utility{

  Utility._privateConstructor();

  static final Utility _instance=Utility._privateConstructor();

  static Utility get instance => _instance;


  hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }

  }

  isAPISuccefull(int statusCode) {
    if (statusCode >= 200 && statusCode <= 300) {
      return true;
    }
    return false;
  }

}