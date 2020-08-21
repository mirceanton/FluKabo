import 'package:flukabo/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// TODO doc

///
/// An abstract class from which all the tabs in the HomePage
/// are derived.
/// This is implemented so that each tab can have a [name] and
/// an [icon] associated to it.
///
abstract class HomeTab {
  const HomeTab();

  String getName();
  IconData getIcon();
  Future<void> refresh();

  Widget buildSelf();

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
        return buildSelf();
      //! return _buildInitPage();
    }
  }

  void _mainListener(BuildContext context, AuthState state) {
    if (state is AuthErrorState) {
      _showSnackbar(context: context, content: state.errmsg);
    }
  }

  Widget getBody() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _mainListener,
      builder: _mainBuilder,
    );
  }

  void _showSnackbar({BuildContext context, String content}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  Widget _buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildInitPage() => Container();

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
