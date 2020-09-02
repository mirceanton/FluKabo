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
  UserModel.fromJson(Map<String, String> json)
      : _id = int.parse(json['id']),
        _username = json['username'],
        _password = json['password'],
        _isLdap = json['is_ldap_user'] == "1",
        _name = json['name'],
        _email = json['email'],
        _googleId =
            json['google_id'] == null ? 0 : int.parse(json['google_id']),
        _githubId =
            json['github_id'] == null ? 0 : int.parse(json['github_id']),
        _notificationsEnabled = json['notifications_enabled'] == "1",
        _timezone = json['timezon'],
        _language = json['language'],
        _disableLogin = json['disable_login_form'] == "1",
        _has2Fa = json['twofactor_activated'] == "1",
        _twoFaSecret = json['twofactor_secret'],
        _token = json['token'],
        _notifFilter = int.parse(json['notifications_filter']) ?? 0,
        _failedLogins = int.parse(json['nb_failed_login']) ?? 0,
        _lockExpirationDate = json['lock_expiration_date'],
        _gitlabId =
            json['gitlab_id'] == null ? 0 : int.parse(json['gitlab_id']),
        _role = json['role'],
        _isActive = json['is_active'] == "1",
        _avatar = json['avatar_path'],
        _apiToken = json['api_access_token'],
        _filter = json['filter'];

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
