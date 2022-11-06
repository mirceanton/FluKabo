import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/singletons/user_preferences.dart';
import '../../res/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// A BLoC made to handle switching from the light theme to the dark one and
/// vice versa
class ThemeBloc extends Bloc<ThemeSwitchEvent, ThemeState> {
  final AppTheme initialTheme;
  ThemeBloc(this.initialTheme)
      : super(ThemeState(themeData: appThemeData[initialTheme]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeSwitchEvent event,
  ) async* {
    if (event is ThemeSwitchEvent) {
      if (state.themeData.brightness == Brightness.dark) {
        yield ThemeState(themeData: appThemeData[AppTheme.Light]);
      } else {
        yield ThemeState(themeData: appThemeData[AppTheme.Dark]);
      }
      UserPreferences().switchTheme();
    }
  }
}
