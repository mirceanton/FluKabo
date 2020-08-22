import 'package:flukabo/res/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/theme/theme.dart';

/// A singleton made to simplify interacting with the Shared Preferences
class UserPreferences {
  SharedPreferences _preferences;
  static final UserPreferences _instance = UserPreferences._constructor();
  factory UserPreferences() => _instance;
  UserPreferences._constructor(); // empty constructor

  /// [init] caches a shared preferences instance
  Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  // Get Values From
  String get baseUrl =>
      _preferences.getString(keys[Prefs.BaseURL]) ??
      defaults[Prefs.BaseURL].toString();
  String get port =>
      _preferences.getString(keys[Prefs.Port]) ??
      defaults[Prefs.Port].toString();
  String get api =>
      _preferences.getString(keys[Prefs.API]) ?? defaults[Prefs.API].toString();
  String get fullAddress => '$baseUrl:$port/$api';
  bool get acceptAllCerts =>
      _preferences.getBool(keys[Prefs.Certs]) ?? defaults[Prefs.Certs] == true;
  String get userName =>
      _preferences.getString(keys[Prefs.User]) ??
      defaults[Prefs.User].toString();
  String get token =>
      _preferences.getString(keys[Prefs.Token]) ??
      defaults[Prefs.Token].toString();
  String get theme =>
      _preferences.getString(keys[Prefs.Theme]) ??
      defaults[Prefs.Theme].toString();
  bool get isDarkTheme => theme == AppTheme.Dark.toString();

  // Set Values To
  set baseUrl(String _baseUrl) =>
      _preferences.setString(keys[Prefs.BaseURL], _baseUrl);
  set port(String _port) => _preferences.setString(keys[Prefs.Port], _port);
  set api(String _api) => _preferences.setString(keys[Prefs.API], _api);
  set acceptAllCerts(bool _acceptAllCerts) =>
      _preferences.setBool(keys[Prefs.Certs], _acceptAllCerts);
  set userName(String _userName) =>
      _preferences.setString(keys[Prefs.User], _userName);
  set token(String _token) => _preferences.setString(keys[Prefs.Token], _token);
  set theme(String _theme) => _preferences.setString(keys[Prefs.Theme], _theme);

  // Toggle functions
  void switchTheme() {
    if (theme == AppTheme.Dark.toString()) {
      theme = AppTheme.Light.toString();
    } else {
      theme = AppTheme.Dark.toString();
    }
  }

  void toggleCerts() => acceptAllCerts = !acceptAllCerts;
}
