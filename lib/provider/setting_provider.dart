import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/firebase/firebase_function.dart';
import 'package:todo_task/models/user_model.dart';

import '../firebase/firebase_function.dart';


class SettingProvid extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.system;
  String language="en";

  UserModel? myUser;
  User? fireBaseUser;

  SettingProvid(){
    fireBaseUser=FirebaseAuth.instance.currentUser;
    if(fireBaseUser !=null){
      initUser();
    }
  }


  Future<void> changThem(ThemeMode  mode) async {
    if(mode==themeMode){
      return;
    }
    else{
      themeMode=mode;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'themeMode',
        themeMode == ThemeMode.dark ?
        'dark'
            : themeMode == ThemeMode.system ? 'system'
            : 'light');
    notifyListeners();
  }
  Future<void> changlang(String lang) async {
    if(lang==language){
      return;
    }
    else{
      language=lang;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    notifyListeners();
  }

  Future<void> initUser()async {
    fireBaseUser=FirebaseAuth.instance.currentUser;
    myUser= await FirebaseFunctions.readUser(fireBaseUser!.uid);
    notifyListeners();
  }
  void logOut(){
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }




}