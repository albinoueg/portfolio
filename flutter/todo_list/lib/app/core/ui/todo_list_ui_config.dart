
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
    textTheme: GoogleFonts.mandaliTextTheme(),
    primaryColor: const Color(0xff5c77CE),
    primaryColorLight: const Color(0xffABC8F7),
  );
}