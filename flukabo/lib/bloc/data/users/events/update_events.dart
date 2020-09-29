import '../../../../data/models/user.dart';
import '../users_bloc.dart';

abstract class UpdateUserEvent extends UserEvent {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUser extends UpdateUserEvent {
  final UserModel updatedUser;

  const UpdateUser({this.updatedUser});

  @override
  List<Object> get props => [updatedUser];
}

class EnableUser extends UpdateUserEvent {
  final int userId;

  const EnableUser({this.userId});

  @override
  List<Object> get props => [userId];
}

class DisableUser extends UpdateUserEvent {
  final int userId;

  const DisableUser({this.userId});

  @override
  List<Object> get props => [userId];
}
