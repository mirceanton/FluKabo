import 'package:flutter/material.dart';

import '../tasks_bloc.dart';

class DeleteTask extends TasksEvent {
  final int taskId;

  const DeleteTask({@required this.taskId});

  @override
  List<Object> get props => [taskId];
}
