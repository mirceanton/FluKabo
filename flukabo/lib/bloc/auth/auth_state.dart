part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state -> no login attempt made
class AuthInitialState extends AuthState {
  const AuthInitialState();

  @override
  List<Object> get props => [];
}

/// Loading State -> currently processing a login attempt
class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object> get props => [];
}

/// Success State -> login attempt was successful
class AuthSuccessState extends AuthState {
  const AuthSuccessState();

  @override
  List<Object> get props => [];
}

/// Error State -> login attempt failed
class AuthErrorState extends AuthState {
  final int errno; // error number
  final String errmsg; // error message
  const AuthErrorState({this.errno, @required this.errmsg});

  @override
  List<Object> get props => [errno, errmsg];
}
