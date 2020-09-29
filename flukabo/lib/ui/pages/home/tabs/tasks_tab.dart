import 'package:flukabo/bloc/data/tasks/events/events.dart';
import 'package:flukabo/bloc/data/tasks/states/states.dart';
import 'package:flukabo/ui/templates/bloc_widgets/task_bloc_widgets.dart';
import 'package:flukabo/ui/templates/task/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../bloc/data/tasks/functions.dart' as task;
import '../../../../bloc/data/tasks/tasks_bloc.dart';
import 'abstract_tab_class.dart';

class TasksTab extends HomeTab {
  TasksTab();

  @override
  String get name => 'Tasks';
  @override
  IconData get icon => MdiIcons.checkBold;

  @override
  HomeTabState createState() => _TasksTabState();
}

class _TasksTabState extends HomeTabState {
  Widget _successBuilder(BuildContext context, TasksState state) {
    if (state is TaskListFetched) {
      if (state.tasks.isEmpty) {
        return const TaskBlocEmptyContentWidget();
      } else {
        return TaskListView(
          height: double.infinity,
          width: double.infinity,
          tasks: state.tasks,
        );
      }
    }
    return const SizedBox(width: 0, height: 0);
  }

  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: task.listener,
        builder: (context, state) => task.builder(
          context,
          state,
          defaultEvent: const FetchAllTasksForProject(
            projectId: 1,
            isActive: true,
          ), // FIXME
          successBuilder: _successBuilder,
        ),
      ),
    );
  }
}
