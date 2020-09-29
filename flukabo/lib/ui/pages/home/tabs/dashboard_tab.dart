import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/data/projects/events/events.dart';
import '../../../../bloc/data/projects/functions.dart' as project;
import '../../../../bloc/data/projects/projects_bloc.dart';

import '../../../../bloc/data/tasks/events/events.dart';
import '../../../../bloc/data/tasks/functions.dart' as task;
import '../../../../bloc/data/tasks/tasks_bloc.dart';

import '../../../../res/dimensions.dart';

import 'abstract_tab_class.dart';

/// A pretty-fied text widget
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Text(
        title,
        style: const TextStyle(
          letterSpacing: 1.2,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// A horizontal scrolling list with starred projects in the CardLayout
class StarredProjectsSection extends StatelessWidget {
  const StarredProjectsSection();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: BlocConsumer<ProjectsBloc, ProjectsState>(
        listener: project.listener,
        builder: (context, state) => project.builder(
          context,
          state,
          defaultEvent: const FetchAllEvent(),
          successBuilder: project.cardListBuilder,
        ),
      ),
    );
  }
}

///
/// A vertical scrolling list with tasks assigned to the current user in
/// ListTile Layout
///
class YourTasksSection extends StatelessWidget {
  const YourTasksSection();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: task.listener,
        builder: (context, state) => task.builder(
          context,
          state,
          defaultEvent: const FetchAllForProjectEvent(
            projectId: 1,
            isActive: true,
          ), // FIXME
          successBuilder: task.taskListBuilder,
        ),
      ),
    );
  }
}

class DashboardTab extends HomeTab {
  DashboardTab(); // empty constructor

  @override
  String get name => 'Dashboard';
  @override
  IconData get icon => Icons.dashboard;

  @override
  HomeTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends HomeTabState {
  @override
  Widget buildContent() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectsBloc()),
        BlocProvider(create: (context) => TasksBloc()),
      ],
      child: Column(
        children: const [
          SectionTitle(title: 'Starred Projects'),
          StarredProjectsSection(),
          Divider(height: 0.5),
          SectionTitle(title: 'Your Tasks'),
          YourTasksSection(),
        ],
      ),
    );
  }
}
