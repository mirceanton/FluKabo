import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flukabo/ui/commons.dart';
import 'package:flukabo/ui/templates/bloc_widgets/auth_bloc_widgets.dart';
import 'package:flukabo/ui/templates/bloc_widgets/bloc_commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_bloc.dart';

/// [retryAuth] adds a new [AuthEvent] to the bloc queue
void retryAuth(BuildContext context) {
  context.bloc<AuthBloc>().add(
        AuthEvent(
          url: UserPreferences().fullAddress,
          username: UserPreferences().userName,
          token: UserPreferences().token,
          acceptAllCerts: UserPreferences().acceptAllCerts,
        ),
      );
}

///
/// [builder] is the builder function called by the AuthBlocConsumer
/// It handles building the appropriate Layout for each state:
///   - AuthLoadingState => [AuthBlocLoadingWidget]
///   - AuthSuccessState => [contentWidget]
///   - AuthErrorState => [AuthBlocErrorWidget]
///   - AuthInitialState => [InitialBlocWidget]
///
Widget builder(BuildContext context, AuthState state, Widget contentWidget) {
  switch (state.runtimeType) {
    case AuthLoading:
      print('Loading auth data...');
      return const AuthBlocLoadingWidget();
    case AuthSuccess:
      print('Authentication successful');
      return contentWidget;
    case AuthError:
      print('Authentication failed');
      return const AuthBlocErrorWidget();
    default: // this includes the [AuthInitialState]
      print("Initial auth state");
      retryAuth(context);
      return const InitialBlocWidget();
  }
}

/// [listener] handles showing the snackbar if the state is [AuthError]
void listener(BuildContext context, AuthState state) {
  if (state is AuthError) {
    showSnackbar(context: context, content: state.errmsg);
  }
}
