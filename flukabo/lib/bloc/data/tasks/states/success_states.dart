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
class TaskCreatedState extends SuccessState {
  final TaskModel task;

  const TaskCreatedState(this.task);

  @override
  List<Object> get props => [task];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByReferenceEvent]
class TaskFetchedState extends SuccessState {
  final TaskModel task;

  const TaskFetchedState(this.task);

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
class TaskListFetchedState extends SuccessState {
  final List<TaskModel> tasks;

  const TaskListFetchedState(this.tasks);

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
class TaskUpdatedState extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const TaskUpdatedState(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [DeleteEvent]
///
class TaskDeletedState extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const TaskDeletedState(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}
