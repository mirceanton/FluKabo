import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/task.dart';
import '../../../../ui/templates/task/task_list_view.dart';
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

  ///
  /// [buildSelf] returns the unique layout of the TasksTab
  /// this is simply a List showcasing all of the tasks in the List Tile view
  ///
  @override
  Widget buildSelf() {
    return RefreshIndicator(
      onRefresh: refresh,
      child: TaskListView(
        tasks: _tasks,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
