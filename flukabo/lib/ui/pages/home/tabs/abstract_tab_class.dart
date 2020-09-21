import 'package:flukabo/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        return buildLoadingIndicator();
      case AuthSuccessState:
        print('Authentication successful');
        return buildContent();
      case AuthErrorState:
        print('Authentication failed');
        return buildErrorIndicator(context);
      default: // this includes the [AuthInitialState]
        print("Initial auth state");
        return buildInitPage();
    }
  }

  ///
  /// [showSnackbar] is self explanatory. It will display the given [content]
  /// in a custom snackbar
  ///
  void showSnackbar({BuildContext context, String content}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  /// [buildLoadingIndicator] simply returns a centered loading bar
  Widget buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  ///
  /// [buildInitPage] returns an empty container, a placeholder widget while
  ///  the event is getting sent to the bloc
  ///
  Widget buildInitPage() => Container();

  /// [buildErrorIndicator] returns a centered icon-text pair
  Widget buildErrorIndicator(BuildContext context) {
    return Column(children: [
      Expanded(child: Container()),
      Icon(
        MdiIcons.lanDisconnect,
        size: 128.0,
        color: Theme.of(context).primaryColorLight,
      ),
      const SizedBox(height: 32.0),
      Text(
        'Connection failed',
        style: TextStyle(
          letterSpacing: 1.25,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      Expanded(child: Container()),
    ]);
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
