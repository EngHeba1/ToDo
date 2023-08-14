import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_task/screens/widgets/showLangugeBottomSheet.dart';
import 'package:todo_task/screens/widgets/showThem.dart';

import '../styles/text_style.dart';
import 'log_in.dart';

class SettingsTap extends StatelessWidget {
  const SettingsTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<SettingProvid>(context);
    return Scaffold(
        appBar:AppBar(
        centerTitle: true,
        title: pro.language=="en"?
        Text("Settings",style: GoogleFonts.novaSquare()):
        Text("الإعدادات",
            style: GoogleFonts.cairo()),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
    )
    ),
          toolbarHeight: 50.h,
          ),
      body: Padding(
         padding: EdgeInsets.all(25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: pro.language == "ar"
                      ? MediaQuery.of(context).size.height * 0.03
                      : MediaQuery.of(context).size.height * 0.08),
              Text(AppLocalizations.of(context)!.language,
                  style: pro.themeMode == ThemeMode.light
                      ? pro.language == "en"
                      ? AppTexts.NovaSquare12BlackLight()
                      .copyWith(fontSize: 16.sp)
                      : GoogleFonts.cairo()
                      : pro.language == "en"
                      ? AppTexts.NovaSquare12WhiteDark()
                      .copyWith(fontSize: 16.sp)
                      : GoogleFonts.cairo()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: () {
                  showLanguageSheet(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  padding: pro.language == "ar"
                      ? EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.02)
                      : EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pro.language == 'en'
                          ? Text(
                        AppLocalizations.of(context)!.english,
                        style: GoogleFonts.novaSquare(),
                      )
                          : Text(
                        AppLocalizations.of(context)!.arabic,
                        style: GoogleFonts.cairo(),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                      )
                    ],
                  ),
                ),
              ),
              Text(AppLocalizations.of(context)!.theme,
                  style: pro.themeMode == ThemeMode.light
                      ? pro.language == "en"
                      ? AppTexts.NovaSquare12BlackLight()
                      .copyWith(fontSize: 16.sp)
                      : GoogleFonts.cairo()
                      : pro.language == "en"
                      ? AppTexts.NovaSquare12WhiteDark()
                      .copyWith(fontSize: 16.sp)
                      : GoogleFonts.cairo()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: () {
                  showThemeSheet(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  padding: pro.language == "ar"
                      ? EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.02)
                      : EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pro.themeMode == ThemeMode.light
                          ? Text(AppLocalizations.of(context)!.lightMood,
                          style: pro.language == "en"
                              ? GoogleFonts.novaSquare()
                              : GoogleFonts.cairo())
                          : pro.themeMode == ThemeMode.system
                          ? Text(AppLocalizations.of(context)!.systemMood,
                          style: pro.language == "en"
                              ? GoogleFonts.novaSquare()
                              : GoogleFonts.cairo())
                          : Text(AppLocalizations.of(context)!.darkMood,
                          style: pro.language == "en"
                              ? GoogleFonts.novaSquare()
                              : GoogleFonts.cairo()),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                      )
                    ],
                  ),
                ),
              ),

            ]),
      ),
    );
  }

  void showLanguageSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => ShowLangugeBottomSheet());
  }

  void showThemeSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => ShowThem());
  }
}
