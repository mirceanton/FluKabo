import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../data/singletons/kanboard_api_client.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // we don't have to check for event type since we only have 1 type of events
    yield const AuthLoading();
    try {
      await KanboardAPI().testConnection(
        url: event.url,
        user: event.username,
        token: event.token,
        acceptCerts: event.acceptAllCerts,
      );
      yield const AuthSuccess();
    } on Failure catch (f) {
      yield AuthError(errmsg: f.message);
    }
  }
}
