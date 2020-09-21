import 'package:flutter/material.dart';
import '../../../data/models/task.dart';

// TODO implement me
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
        child: Text(_task.title),
      ),
    );
  }
}
