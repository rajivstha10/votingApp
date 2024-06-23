import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votingapp/core/theme/colors.dart';

/// Theme Data
ThemeData themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: primaryColor,
    foregroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  useMaterial3: false,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.136,
      color: primaryColor,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      height: 1.5,
      letterSpacing: 0.136,
      color: primaryColor,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: primaryColor,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: primaryColor,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      height: 1.5,
      color: primaryColor,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5,
      color: primaryColor,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: primaryColor.withOpacity(0.5),
    secondary: secondaryColor,
    onSecondary: secondaryColor.withOpacity(0.5),
    error: Colors.red,
    onError: Colors.red,
    surface: containerColor,
    onSurface: containerColorDark,
  ),
);
