import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // we don't have to check for event type since we only have 1 type of events
    yield const AuthLoadingState();
    try {
      // TODO attempt login(event.url, event.port, event.api, event.certs, event.username, event.token)
      yield const AuthSuccessState();
    } catch (e) {
      // todo implement proper error handling
      yield const AuthErrorState(errmsg: 'error');
    }
  }
}
