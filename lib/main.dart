import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_task/screens/creat_account.dart';
import 'package:todo_task/screens/edit_task.dart';
import 'package:todo_task/screens/log_in.dart';
import 'package:todo_task/screens/updat_task.dart';
import 'package:todo_task/styles/my_theme.dart';

import 'firebase_options.dart';
import 'home_layout/home_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // FirebaseFirestore.instance.disableNetwork();
  runApp( ChangeNotifierProvider(
      create: (BuildContext context) => SettingProvid(),
      child: MyApp()));
}


class MyApp extends StatelessWidget {
   late SettingProvid pro;
  @override
  Widget build(BuildContext context) {
    pro=Provider.of<SettingProvid>(context);
    intialPrefraances();
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? child) {
      return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: [Locale("en"),Locale("ar")],
          debugShowCheckedModeBanner: false,
        routes: {
          HomeLayout.routName :(context) => HomeLayout(),
          //EditTask.routeName   :(context) => EditTask(),
          EditTask.rouitName : (context) => EditTask(),
          LogIn.routName :(context) => LogIn(),
          CreatAccount.routName :(context) => CreatAccount()


        },
        initialRoute:pro.fireBaseUser!=null? HomeLayout.routName:LogIn.routName ,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
        themeMode:pro.themeMode ,
        locale: Locale(pro.language)
    );
  }
    );}
  Future<void>intialPrefraances()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String? lang= prefs.getString('language');
   String? theme =prefs.getString('themeMode');
   pro.changlang(lang??="en");
   if(theme=="light"){
     pro.changThem(ThemeMode.light);
   }
   else if(theme=='dark'){
     pro.changThem(ThemeMode.dark);
   }
  }      

    
  }

