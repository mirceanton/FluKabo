import 'package:flukabo/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TaskTile extends StatelessWidget {
  final TaskModel _task;
  const TaskTile(this._task);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {}, // todo navigate to task page
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: _task.buildIcon(),
        title: _task.buildTitle(),
        subtitle: Text(_task.description),
      ),
    );
  }
}
