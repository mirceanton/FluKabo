import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_bloc.dart';

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
