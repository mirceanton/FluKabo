part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state -> no login attempt made
class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

/// Loading State -> currently processing a login attempt
class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

/// Success State -> login attempt was successful
class AuthSuccess extends AuthState {
  const AuthSuccess();

  @override
  List<Object> get props => [];
}

/// Error State -> login attempt failed
class AuthError extends AuthState {
  final int errno; // error number
  final String errmsg; // error message
  const AuthError({
    this.errno,
    @required this.errmsg,
  });

  @override
  List<Object> get props => [errno, errmsg];
}
