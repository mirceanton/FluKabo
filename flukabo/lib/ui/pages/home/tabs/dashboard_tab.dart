import 'package:flutter/material.dart';
import '../../../../data/models/project.dart';
import '../../../../data/models/task.dart';
import '../../../../ui/templates/project/project_list_view.dart';
import '../../../../ui/templates/task/task_list_view.dart';

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

  ///
  /// [buildSelf] returns the unique layout of the DashboardTab
  /// This layout consists of a Horizontal Scrolling list, highlighting the
  /// personal Projects of the active user, showing them in the Card Layout,
  /// followed by a Vertical scrolling list, populated by all the tasks assigned
  /// to the user, showed in the List Tile layout
  /// Each of the lists has a title above it
  ///
  @override
  Widget buildSelf() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
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
                alignment: Alignment.centerLeft,
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
