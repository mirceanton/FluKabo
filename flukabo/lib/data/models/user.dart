import 'package:flukabo/data/helpers/json_parser.dart';

class UserModel {
  int _id;
  String _username;
  String _password;
  bool _isLdap;
  String _name;
  String _email;
  int _googleId;
  int _githubId;
  bool _notificationsEnabled;
  String _timezone;
  String _language;
  bool _disableLogin;
  bool _has2Fa;
  String _twoFaSecret;
  String _token;
  int _notifFilter;
  int _failedLogins;
  int _gitlabId;
  String _role;
  bool _isActive;
  String _avatar;
  String _apiToken;
  String _lockExpirationDate;
  String _filter;

  UserModel.empty();
  UserModel.fromJson(Map<String, String> json) {
    _id = parseToInt(json['id'].toString());
    _username = parseToString(json['username'].toString());
    _password = parseToString(json['password'].toString());
    _isLdap = parseToBool(json['is_ldap_user'].toString());
    _name = parseToString(json['name'].toString());
    _email = parseToString(json['email'].toString());
    _googleId = parseToInt(json['google_id'].toString());
    _githubId = parseToInt(json['github_id'].toString());
    _notificationsEnabled =
        parseToBool(json['notifications_enabled'].toString());
    _timezone = parseToString(json['timezon'].toString());
    _language = parseToString(json['language'].toString());
    _disableLogin = parseToBool(json['disable_login_form'].toString());
    _has2Fa = parseToBool(json['twofactor_activated'].toString());
    _twoFaSecret = parseToString(json['twofactor_secret'].toString());
    _token = parseToString(json['token'].toString());
    _notifFilter = parseToInt(json['notifications_filter'].toString());
    _failedLogins = parseToInt(json['nb_failed_login'].toString());
    _lockExpirationDate =
        parseToString(json['lock_expiration_date'].toString());
    _gitlabId = json['gitlab_id'] == null ? 0 : int.parse(json['gitlab_id']);
    _role = parseToString(json['role'].toString());
    _isActive = parseToBool(json['is_active'].toString());
    _avatar = parseToString(json['avatar_path'].toString());
    _apiToken = parseToString(json['api_access_token'].toString());
    _filter = parseToString(json['filter'].toString());
  }

  // Getters
  int get id => _id;
  String get username => _username;
  String get password => _password;
  bool get isLdap => _isLdap;
  String get name => _name;
  String get email => _email;
  int get googleId => _googleId;
  int get githubId => _githubId;
  bool get notificationsEnabled => _notificationsEnabled;
  String get timezone => _timezone;
  String get language => _language;
  bool get disableLogin => _disableLogin;
  bool get hasTwoFa => _has2Fa;
  String get twoFaSecret => _twoFaSecret;
  String get token => _token;
  int get notifFilter => _notifFilter;
  int get failedLogins => _failedLogins;
  int get gitlabId => _gitlabId;
  String get role => _role;
  bool get isActive => _isActive;
  String get avatar => _avatar;
  String get apiToken => _apiToken;
  String get lockExpirationDate => _lockExpirationDate;
  String get filter => _filter;
}
