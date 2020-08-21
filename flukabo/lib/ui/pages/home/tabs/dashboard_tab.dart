import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/task.dart';
import 'package:flutter/material.dart';

import 'abstract_tab_class.dart';

class DashboardTab extends HomeTab {
  final List<ProjectModel> projects;
  final List<TaskModel> tasks;
  const DashboardTab({
    @required this.projects,
    @required this.tasks,
  }); // empty constructor

  @override
  String getName() => 'Dashboard';
  @override
  IconData getIcon() => Icons.dashboard;

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
