import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../ui/templates/task/task_tile.dart';

///
/// A basic LisView.separated with a custom [width] and [height]
/// Each item is a TaskTile and each separator is a Divider
///
class TaskListView extends StatelessWidget {
  final List<TaskModel> tasks;
  final double width, height;
  const TaskListView({
    @required this.tasks,
    @required this.width,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(height: 1.0),
        itemBuilder: (context, index) => TaskTile(tasks[index]),
      ),
    );
  }
}
