import '../../../../data/models/user.dart';
import '../users_bloc.dart';

class CreateUser extends UserEvent {
  final UserModel newUser;

  const CreateUser({this.newUser});

  @override
  List<Object> get props => [newUser];
}
