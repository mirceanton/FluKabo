import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/data/projects/events/events.dart';
import '../../../../bloc/data/projects/projects_bloc.dart';
import '../../../../bloc/data/tasks/events/fetch_events.dart';
import '../../../../bloc/data/tasks/tasks_bloc.dart';

import '../../../../ui/templates/project/project_list_consumer.dart';
import '../../../../ui/templates/task/task_list_consumer.dart';

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
          ProjectCardListBlocConsumer(FetchStarredProjects()),
          Divider(height: 0.5),
          SectionTitle(title: 'Your Tasks'),
          TasksTileListBlocConsumer(
              FetchAllTasksForProject(projectId: 1, isActive: true)),
        ],
      ),
    );
  }
}
