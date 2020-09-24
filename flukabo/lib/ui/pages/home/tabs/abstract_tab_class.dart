import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flukabo/ui/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../bloc/auth/auth_bloc.dart';

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
  // Send an auth event with the fields from UserPreferences()
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
  /// [_mainBuilder] is the builder function called by the BlocConsumer
  /// It handles building the appropriate Layout for each state:
  ///   - AuthLoadingState => [_buildLoadingIndicator]
  ///   - AuthSuccessState => [buildContent]
  ///   - AuthErrorState => [_buildError]
  ///   - AuthInitialState => [_buildInitPage]
  ///
  Widget _mainBuilder(BuildContext context, AuthState state) {
    switch (state.runtimeType) {
      case AuthLoadingState:
        print('Loading auth data...');
        return buildLoading();
      case AuthSuccessState:
        print('Authentication successful');
        return buildContent();
      case AuthErrorState:
        print('Authentication failed');
        return buildError(
          context,
          icon: MdiIcons.accessPointNetworkOff,
          message: 'Connection failed',
          onButtonPress: () => retryAuth(context),
        );
      default: // this includes the [AuthInitialState]
        print("Initial auth state");
        retryAuth(context);
        return buildInitial();
    }
  }

  ///
  /// [buildContent] will return the actual UI of this tab, assuming the
  /// AuthState is AuthSuccessState
  /// This layout will be unique to each tab and should be overriden in every
  /// implementation
  ///
  Widget buildContent() => Container();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, __) {},
      builder: _mainBuilder,
    );
  }
}
