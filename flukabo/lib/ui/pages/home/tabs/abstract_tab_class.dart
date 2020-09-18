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
abstract class HomeTab {
  const HomeTab();

  ///
  /// [getName] will return the name associated to this tab.
  /// Having this method allows us to skip creating a list of String to hold
  /// the tab names in the HomePage
  ///
  String getName();

  ///
  /// [getIcon] will return the icon associated to this tab.
  /// Having this method allows us to skip creating a list of IconData to pass
  /// to the BottomNavBar
  ///
  IconData getIcon();

  // TODO not sure if this is actually needed
  Future<void> refresh();

  ///
  /// [buildSelf] will return the actual UI of this tab, assuming the AuthState
  /// is AuthSuccessState
  /// This layout will be unique to each tab and should be overriden in every
  /// implementation
  ///
  Widget buildSelf();

  ///
  /// [_mainBuilder] is the builder function called by the BlocConsumer which
  /// constitutes the body of a HomeTab
  /// It handles building the appropriate Layout for each state:
  ///   - AuthLoadingState => _buildLoadingIndicator()
  ///   - AuthSuccessState => buildSelf()
  ///   - AuthErrorState => _buildError()
  ///   - AuthInitialState => _buildInitPage()
  ///
  Widget _mainBuilder(BuildContext context, AuthState state) {
    switch (state.runtimeType) {
      case AuthLoadingState:
        print('Loading data...');
        return _buildLoadingIndicator();
      case AuthSuccessState:
        print('Authentication successful');
        return buildSelf();
      case AuthErrorState:
        print('Authentication failed');
        return _buildErrorIndicator(context);
      default: // this includes the [AuthInitialState]
        print("Initial state");
        return _buildInitPage();
    }
  }

  ///
  /// [getBody] returns the 'state-aware content'.
  /// In other words, whenever a HomeTab is implemented, the UI will come from
  /// this function, not from buildSelf(), as this one is able to respond
  /// to the states created by the AuthBloc.
  ///
  Widget getBody() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, __) {},
      builder: _mainBuilder,
    );
  }

  ///
  /// [_showSnackbar] is self explanatory. It will display the given [content]
  /// in a custom snackbar
  ///
  void _showSnackbar({BuildContext context, String content}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  ///
  /// [_buildLoadingIndicator] simply returns a centered loading bar
  ///
  Widget _buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  ///
  /// [_buildInitPage] returns an empty container.
  /// This is the layout that will get displayed in the time between starting
  /// the app, and the AuthEvent getting registered. From there, the loading
  /// layout is next, followed by the success or error layouts
  ///
  Widget _buildInitPage() => Container();

  ///FIXME
  /// [_buildErrorIndicator] returns a centered icon-text pair
  ///
  Widget _buildErrorIndicator(BuildContext context) {
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
}
