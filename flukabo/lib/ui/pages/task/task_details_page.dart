import 'package:flukabo/ui/templates/template_commons.dart';
import 'package:flutter/material.dart';
import '../../../data/models/task.dart';

// TODO implement me
class TaskDetailsPage extends StatelessWidget {
  final TaskModel task;
  const TaskDetailsPage(this.task);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleTemplate(
          objectId: task.id,
          title: task.title,
          color: Colors.white,
        ),
        // backgroundColor: _task.priorityColor,
      ),
      body: Center(
        child: Text(task.title),
      ),
    );
  }
}
