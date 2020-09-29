import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/auth/functions.dart' as auth;

///
/// An abstract class from which all the tabs in the HomePage are derived.
///
/// This is implemented so that each tab can have a specific pattern to follow.
/// This is helpful as it allows some handy implementations, such as:
///  - create a list of HomeTabs using polymorphism, and being able to call
///    getName, getIcon, getBody etc on them
///  - get rid of a lot of boilerplate code, such as implementing the BLoC
///    builder and listener for each tab individually
///  - allows us to reuse UI elements, such as the Loading screen, the Error
///    Screen and the initial, empty screen
///
abstract class HomeTab extends StatefulWidget {
  // Getters
  String get name; // the name associated to the tab (for app bar title)
  IconData get icon; // the icon associated to the tab (for bottom tab bar)

  @override
  // ignore: no_logic_in_create_state
  HomeTabState createState();
}

abstract class HomeTabState extends State<HomeTab> {
  ///
  /// [buildContent] will return the actual UI of each tab, assuming the
  /// AuthState is AuthSuccessState
  /// This layout will be unique to each tab and should be overriden in every
  /// implementation
  ///
  Widget buildContent() => Container();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: auth.listener,
      builder: (context, state) => auth.builder(context, state, buildContent()),
    );
  }
}
