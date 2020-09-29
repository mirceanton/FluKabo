import 'package:flukabo/bloc/data/users/events/events.dart';
import 'package:flukabo/bloc/data/users/states/states.dart';
import 'package:flukabo/bloc/data/users/users_bloc.dart';
import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flukabo/ui/templates/bloc_widgets/auth_bloc_widgets.dart';
import 'package:flukabo/ui/templates/bloc_widgets/bloc_commons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../commons.dart';
import 'abstract_tab_class.dart';

class AccountTab extends HomeTab {
  AccountTab();

  @override
  String get name => 'Account';
  @override
  IconData get icon => MdiIcons.account;

  @override
  HomeTabState createState() => _AccountTabState();
}

class _AccountTabState extends HomeTabState {
  Widget _builder(BuildContext context, UserState state) {
    if (state is LoadingState) {
      return const LoadingBlocWidget('Fetching active user...');
    } else if (state is ErrorState) {
      return const AuthBlocErrorWidget();
    } else if (state is SuccessState) {
      if (state is UserFetchedState) {
        return Center(child: Text("${state.user.name} - ${state.user.email}"));
      }
    }
    // if the state is InitState, attempt a Fetch Event
    context.bloc<UsersBloc>().add(
          FetchUserByUsername(
            username: UserPreferences().userName,
          ),
        );
    return const InitialBlocWidget();
  }

  void _listener(BuildContext context, UserState state) {
    if (state is ErrorState) {
      showSnackbar(
        context: context,
        content: state.errmsg,
      );
    }
  }

  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: BlocConsumer<UsersBloc, UserState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }
}
