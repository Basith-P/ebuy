import 'package:flutter/material.dart';

var themeData = ThemeData(
  primarySwatch: Colors.blueGrey,
  fontFamily: 'Lato',
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
      ),
  scaffoldBackgroundColor: Colors.blueGrey[50],
  snackBarTheme: const SnackBarThemeData().copyWith(
    behavior: SnackBarBehavior.floating,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
