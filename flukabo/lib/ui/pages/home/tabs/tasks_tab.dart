import 'package:flukabo/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'abstract_tab_class.dart';

class TasksTab extends HomeTab {
  final List<TaskModel> _tasks;
  const TasksTab(this._tasks);

  @override
  String getName() => 'Tasks';
  @override
  IconData getIcon() => MdiIcons.checkBold;

  @override
  Future<void> refresh() async {
    //TODO
  }

  // TODO
  @override
  Widget buildSelf() {
    return Center(
      child: Text(
        getName(),
      ),
    );
  }
}
