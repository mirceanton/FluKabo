// ignore: constant_identifier_names
import 'package:flukabo/res/app_themes.dart';

// ignore: constant_identifier_names
enum Prefs { BaseURL, Port, API, Certs, User, Token, Theme }

Map<Prefs, dynamic> defaults = {
  Prefs.BaseURL: 'https://0.0.0.0',
  Prefs.Port: '80',
  Prefs.API: '/jsonrpc.php',
  Prefs.Certs: false,
  Prefs.User: '',
  Prefs.Token: '',
  Prefs.Theme: AppTheme.Dark.toString(),
};
Map<Prefs, String> keys = {
  Prefs.BaseURL: 'base_url',
  Prefs.Port: 'port',
  Prefs.API: 'api_path',
  Prefs.Certs: 'allow_certs',
  Prefs.User: 'user_name',
  Prefs.Token: 'user_token',
  Prefs.Theme: 'theme',
};
