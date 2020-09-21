import 'package:flutter/material.dart';
import '../../../data/models/task.dart';

///
/// A basic list tile used to showcase a Task
/// The [title] of the tile is the [task name]
/// The [subtitle] is the [task description]
/// The leading icon is a circle with a color based on the task priority
/// [onTap] navigates to the TaskDetails page of [_task]
///
class TaskTile extends StatelessWidget {
  final TaskModel _task;
  const TaskTile(this._task);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _task.navigate(context),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: _task.buildIcon(),
        title: _task.buildTitle(),
        subtitle: Text(_task.description),
      ),
    );
  }
}
