import '../../../../bloc/data/tasks/tasks_bloc.dart';
import '../../../../data/models/models.dart';

abstract class SuccessState extends TasksState {
  const SuccessState();

  @override
  List<Object> get props => [];
}

///
/// ---- SUCCES STATES FOR CREATE EVENTS ----
///
/// The SuccessState associated to [CreateEvent]
class TaskCreated extends SuccessState {
  final TaskModel task;

  const TaskCreated(this.task);

  @override
  List<Object> get props => [task];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByReferenceEvent]
class TaskFetched extends SuccessState {
  final TaskModel task;

  const TaskFetched(this.task);

  @override
  List<Object> get props => [task];
}

///
/// The SuccessState associated to:
///   - [FetchAllForProjectEvent],
///   - [FetchAllOverdueEvent],
///   - [FetchOverdueForProjectEvent]
///   - [SearchEvent]
///
class TaskListFetched extends SuccessState {
  final List<TaskModel> tasks;

  const TaskListFetched(this.tasks);

  @override
  List<Object> get props => [tasks];
}

///
/// ---- SUCCES STATES FOR UPDATE EVENTS ----
///
/// The SuccessState associated to:
///   - [UpdateTaskEvent]
///   - [OpenTaskEvent]
///   - [CloseTaskEvent]
///   - [MoveTaskWithinProjectEvent]
///   - [MoveTaskToProjectEvent]
///   - [CloneTaskToProjectEvent]
///
class TaskUpdated extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const TaskUpdated(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [DeleteEvent]
///
class TaskDeleted extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const TaskDeleted(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}
