import 'package:flutter/material.dart';

// Shared settings
var _bodyLargeTheme = const TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 32,
);
var _bodyMediumTheme = const TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16,
);

var lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: _bodyLargeTheme,
    bodyMedium: _bodyMediumTheme,
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodyLarge: _bodyLargeTheme.copyWith(
      color: Colors.white,
    ),
    bodyMedium: _bodyMediumTheme.copyWith(
      color: Colors.white,
    )),
);