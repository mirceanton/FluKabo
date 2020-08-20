import 'package:flukabo/data/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  final TaskModel _task;
  const TaskDetailsPage(this._task);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _task.buildTitle(),
        backgroundColor: _task.priorityColor,
      ),
      body: Center(
        child: Text(_task.name),
      ),
    );
  }
}
