import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../bloc/data/tasks/events/events.dart';
import '../../../../bloc/data/tasks/tasks_bloc.dart';
import '../../../../ui/templates/task/task_list_consumer.dart';
import 'abstract_tab_class.dart';

class TasksTab extends HomeTab {
  @override
  String get name => 'Tasks';
  @override
  IconData get icon => MdiIcons.checkBold;

  @override
  HomeTabState createState() => _TasksTabState();
}

class _TasksTabState extends HomeTabState {
  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: Column(
        children: const [
          TasksTileListBlocConsumer(
              FetchAllTasksForProject(projectId: 1, isActive: true))
        ],
      ),
    );
  }
}
