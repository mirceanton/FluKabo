part of 'user_bloc.dart';

/// Generic Event from which all events under ./events are extended
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
