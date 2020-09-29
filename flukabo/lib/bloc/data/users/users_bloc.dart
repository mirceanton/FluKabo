import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flukabo/data/models/models.dart';
import 'package:flukabo/data/repository/user_repository.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'events/events.dart';
import 'states/states.dart';

part 'user_event.dart';
part 'user_state.dart';

class UsersBloc extends Bloc<UserEvent, UserState> {
  UsersBloc() : super(const InitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    yield const LoadingState();
    try {
      if (event is CreateUser) {
        final UserModel user = event.newUser;
        user.id = await UserRepository().createUser(
          username: user.username,
          password: user.password,
          name: user.name,
          email: user.email,
          role: user.role,
        );
        yield UserCreatedState(user: user);
      } else if (event is ReadUserEvent) {
        if (event is FetchUserById) {
          yield UserFetchedState(
            user: await UserRepository().getUserById(event.userId),
          );
        } else if (event is FetchUserByUsername) {
          yield UserFetchedState(
            user: await UserRepository().getUserByUsername(event.username),
          );
        } else if (event is FetchAllUsers) {
          yield UsersFetchedState(users: await UserRepository().getAllUsers());
        } else if (event is FetchGroups) {
          yield GroupsFetchedState(
            groups: await UserRepository().getGroupsForUser(event.userId),
          );
        }
      } else if (event is UpdateUserEvent) {
        if (event is UpdateUser) {
          yield UserUpdatedState(
            wasSuccessful: await UserRepository().updateUser(
              id: event.updatedUser.id,
              name: event.updatedUser.name,
              username: event.updatedUser.username,
              email: event.updatedUser.email,
              role: event.updatedUser.role,
            ),
          );
        } else if (event is EnableUser) {
          yield UserUpdatedState(
            wasSuccessful: await UserRepository().enableUser(event.userId),
          );
        } else if (event is DisableUser) {
          yield UserUpdatedState(
            wasSuccessful: await UserRepository().disableUser(event.userId),
          );
        }
      } else if (event is DeleteUserEvent) {
        yield UserRemovedState(
          wasSuccessful: await UserRepository().removeUser(event.userId),
        );
      }
    } on Failure catch (f) {
      yield ErrorState(errmsg: f.message);
    }
  }
}
