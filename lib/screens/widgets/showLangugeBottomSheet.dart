import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowLangugeBottomSheet extends StatelessWidget {
  const ShowLangugeBottomSheet({super.key});

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
                pro.changlang("ar");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.arabic,
                    style: pro.language == "en" ? GoogleFonts.novaSquare() : GoogleFonts.cairo(),
                  ),
                  const Spacer(),
                  Icon(
                    pro.language == "ar"
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
                pro.changlang("en");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text(
                      AppLocalizations.of(context)!.english,
                      style: pro.language == "en" ? GoogleFonts.novaSquare() : GoogleFonts.cairo()
                  ),
                  const Spacer(),
                  Icon(
                    pro.language == "en"
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

  Widget getUnSelectedItemWidget(String text, context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
  }

