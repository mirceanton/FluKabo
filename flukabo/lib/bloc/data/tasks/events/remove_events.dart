import '../tasks_bloc.dart';

class DeleteEvent extends TasksEvent {
  final int taskId;

  const DeleteEvent({this.taskId});

  @override
  List<Object> get props => [taskId];
}
