import 'package:exam1/presentation/pages/diary_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'injection_container.dart' as get_it;

void main() {
  //Initializing singletons in the project
  get_it.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //color of current objects in the project
  final Color objColor = const Color.fromARGB(255, 165, 212, 66);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam 1',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              toolbarHeight: 100.0,
              titleTextStyle: TextStyle(fontSize: 30.0)),
          cardTheme: const CardTheme(elevation: 8.0),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStatePropertyAll(objColor),
          ),
          disabledColor: Colors.grey[700],
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: objColor, elevation: 8.0)),
          fontFamily: GoogleFonts.roboto().fontFamily),
      home: const DiaryPage(),
    );
  }
}
