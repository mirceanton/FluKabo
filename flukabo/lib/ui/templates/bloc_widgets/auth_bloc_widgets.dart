import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../bloc/auth/functions.dart';
import './bloc_commons.dart';

/// An error icon, with contextual information and a retry button
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

/// A loading indicator with some info text underneath
class AuthBlocLoadingWidget extends StatelessWidget {
  const AuthBlocLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const LoadingBlocWidget('Establishing connection');
  }
}
