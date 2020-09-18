part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  
  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}
