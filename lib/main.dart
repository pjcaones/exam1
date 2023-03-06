import 'package:core/core.dart';
import 'package:exam1/features/diary/pages/pages.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localizely_sdk/localizely_sdk.dart';

import 'features/diary/di.dart' as get_it;

void main() {
  get_it.init();

  Localizely.init(
    LocalizationKeys.sdkToken,
    LocalizationKeys.distributionId,
  );
  Localizely.setPreRelease(true);
  runApp(
    ModularApp(
      module: DiaryModule(),
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  //color of current objects in the project
  Color get objColor => const Color.fromARGB(255, 165, 212, 66);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
          titleTextStyle: TextStyle(fontSize: 30),
        ),
        cardTheme: const CardTheme(elevation: 8),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(objColor),
        ),
        disabledColor: Colors.grey[700],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: objColor,
            elevation: 8,
          ),
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}

class DiaryModule extends Module {
  DiaryModule({
    this.isTestMode = false,
    this.testImageList,
  });

  final bool isTestMode;
  final List<XFile>? testImageList;

  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => DiaryPage(
            isTestMode: isTestMode,
            testImageList: testImageList,
          ),
        ),
      ];
}
