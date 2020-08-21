import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/task.dart';
import 'package:flukabo/ui/templates/project/project_list_view.dart';
import 'package:flukabo/ui/templates/task/task_list_view.dart';
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
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: 48.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Personal Projects',
                  style: TextStyle(letterSpacing: 1.5, fontSize: 18),
                ),
              ),
              ProjectListView(
                projects: projects,
                showCards: true,
                width: double.infinity,
                height: 120.0,
              ),
              // ---
              const SizedBox(height: 4.0),
              const Divider(height: 1.0),
              // ---
              Container(
                height: 48.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Your Tasks',
                  style: TextStyle(letterSpacing: 1.5, fontSize: 18),
                ),
              ),
              TaskListView(
                tasks: tasks,
                width: double.infinity,
                height: constraints.maxHeight - 48 - 120 - 5 - 48,
              ),
            ],
          );
        },
      ),
    );
  }
}
