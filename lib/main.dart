import 'package:exam1/features/diary/presentation/pages/pages.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localizely_sdk/localizely_sdk.dart';

import 'di.dart' as get_it;

void main() {
  //Initializing things in the project
  get_it.init();

  const sdkToken = 'af46981a623c443f8ac5c5e28ec376bc1648cd15';
  const distributionId = '2629f09b51fa470b8cd5de819d9a520a';

  Localizely.init(
    sdkToken,
    distributionId,
  );
  Localizely.setPreRelease(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //color of current objects in the project
  Color get objColor => const Color.fromARGB(255, 165, 212, 66);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              toolbarHeight: 100,
              titleTextStyle: TextStyle(fontSize: 30)),
          cardTheme: const CardTheme(elevation: 8),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStatePropertyAll(objColor),
          ),
          disabledColor: Colors.grey[700],
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: objColor, elevation: 8)),
          fontFamily: GoogleFonts.roboto().fontFamily),
      home: const DiaryPage(),
    );
  }
}
