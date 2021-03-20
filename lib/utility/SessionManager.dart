import 'dart:convert';

import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/utility/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
  static String isLogin = "isLogin";
  static String isUserSelected = "UserSelected";


  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;


  static Future<SharedPreferences> init() async{
    _prefsInstance=await _instance;
    return _prefsInstance;
  }

  static Future<bool> setSelectedUser(String selectedUser) async{
     var prefs=await _instance;
     return prefs.setString(isUserSelected, selectedUser);
  }

  static getSelectedUser(){
    return _prefsInstance.getString(isUserSelected);
  }

  static Future<bool> setFirebaseToken(String token) async{
    var prefs=await _instance;
    return prefs.setString(Constant.token, token);
  }

  static getFirebaseToken(){
    return _prefsInstance.getString(Constant.token);
  }



  static Future<bool> setUserId(String token) async{
    var prefs=await _instance;
    return prefs.setString(Constant.userId, token);
  }

  static getUserId(){
    return _prefsInstance.getString(Constant.userId);
  }

  static Future<bool> setUserName(String username) async{
    var prefs=await _instance;
    return prefs.setString(Constant.username, username);
  }

  static getUserName(){
    return _prefsInstance.getString(Constant.username);
  }

  static Future<bool> setGarageId(String garageId) async{
    var prefs=await _instance;
    return prefs.setString(Constant.garageId, garageId);
  }

  static getGarageId(){
    return _prefsInstance.getString(Constant.garageId);
  }



  static Future<bool> setNotification(List<Message> message) async{
    var prefs=await _instance;
    return prefs.setString(Constant.NotificationData, json.encode(message));
  }

  static getNotification(){
    return _prefsInstance.getString(Constant.NotificationData);
  }

  static logout(){
    return _prefsInstance.remove(Constant.userId);
  }


  static garageLogout(){
    return _prefsInstance.remove(Constant.garageId);
  }





}