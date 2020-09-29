import 'package:flukabo/bloc/auth/functions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './bloc_commons.dart';

class AuthBlocErrorWidget extends StatelessWidget {
  const AuthBlocErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const ErrorBlocWidget(
      callback: retryAuth,
      icon: MdiIcons.accessPointNetworkOff,
      message: 'Connection failed',
    );
  }
}

class AuthBlocLoadingWidget extends StatelessWidget {
  const AuthBlocLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const LoadingBlocWidget('Establishing connection');
  }
}
