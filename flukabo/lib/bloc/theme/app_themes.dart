import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum AppTheme { Dark, Light }

final appThemeData = {
  AppTheme.Dark: ThemeData.dark(),
  AppTheme.Light: ThemeData.light(),
};
