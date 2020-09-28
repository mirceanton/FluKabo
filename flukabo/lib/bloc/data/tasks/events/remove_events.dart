import 'package:flutter/material.dart';

import '../tasks_bloc.dart';

class DeleteEvent extends TasksEvent {
  final int taskId;

  const DeleteEvent({@required this.taskId});

  @override
  List<Object> get props => [taskId];
}
