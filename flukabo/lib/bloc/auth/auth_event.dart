part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  final String username, token, url;
  final bool acceptAllCerts;

  const AuthEvent({
    @required this.url,
    @required this.username,
    @required this.token,
    @required this.acceptAllCerts,
  });

  @override
  List<Object> get props => [username, token, url, acceptAllCerts];
}
