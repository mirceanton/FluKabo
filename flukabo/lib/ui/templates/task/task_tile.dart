import 'package:flukabo/ui/templates/task/task_commons.dart';
import 'package:flutter/material.dart';
import '../../../data/models/task.dart';
import '../template_commons.dart';

///
/// A basic list tile used to showcase a Task
/// The [title] of the tile is the [task name]
/// The [subtitle] is the [task description]
/// The leading icon is a circle with a color based on the task priority
/// [onTap] navigates to the TaskDetails page of [task]
///
class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => task.navigate(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      leading: TaskIcon(
        priority: task.priority,
        priorityStart: task.project == null ? 0 : task.project.priorityStart,
        priorityEnd: task.project == null ? 0 : task.project.priorityEnd,
      ),
      title: TitleTemplate(
        text: task.title,
        color: Theme.of(context).textTheme.headline6.color,
      ),
      subtitle: SubtitleTemplate(subtitle: task.description),
    );
  }
}
