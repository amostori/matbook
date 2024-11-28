import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class BoxName {
  static const String boxName = 'myData';
  static const String datesBoxName = 'datesBoxName';
}

class Theming {
  static ThemeData getLightThemeFromSeed() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
      ),
    );
  }

  static ThemeData getDarkThemeFromSeed() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }

  static ThemeData getLightThemeFromFlexColor() {
    return FlexThemeData.light(
      scheme: FlexScheme.dellGenoa,
      useMaterial3: true,
    );
  }

  static ThemeData getDarkThemeFromFlexColor() {
    return FlexThemeData.dark(
      scheme: FlexScheme.dellGenoa,
      useMaterial3: true,
    );
  }
}

class TextStyling {
  static TextStyle getMainTextStyle() {
    return const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle getSubMainTextStyle() {
    return const TextStyle(
      fontSize: 28,
    );
  }
}
