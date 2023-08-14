import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_task/provider/setting_provider.dart';

class ShowThem extends StatelessWidget {
  const ShowThem({super.key});

  @override
  Widget build(BuildContext context) {
     var pro = Provider.of<SettingProvid>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                pro.changThem(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  pro.language == "en"
                      ? Text(
                    AppLocalizations.of(context)!.darkMood,
                    style: GoogleFonts.novaSquare(),
                  )
                      : Text(AppLocalizations.of(context)!.darkMood,
                      style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    pro.themeMode == ThemeMode.dark
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                pro.changThem(ThemeMode.light);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  pro.language == "en"
                      ? Text(
                    AppLocalizations.of(context)!.lightMood,
                    style: GoogleFonts.novaSquare(),
                  )
                      : Text(AppLocalizations.of(context)!.lightMood,
                      style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    pro.themeMode == ThemeMode.light
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                pro.changThem(ThemeMode.system);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  pro.language == "en"
                      ? Text(
                    AppLocalizations.of(context)!.systemMood,
                    style: GoogleFonts.novaSquare(),
                  )
                      : Text(AppLocalizations.of(context)!.systemMood,
                      style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    pro.themeMode == ThemeMode.system
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
