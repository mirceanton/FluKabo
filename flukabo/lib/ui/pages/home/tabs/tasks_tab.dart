import 'package:flukabo/bloc/data/tasks/events/events.dart';
import 'package:flukabo/bloc/data/tasks/states/states.dart';
import 'package:flukabo/bloc/data/tasks/tasks_bloc.dart';
import 'package:flukabo/ui/templates/bloc_widgets/bloc_commons.dart';
import 'package:flukabo/ui/templates/task/task_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
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
  Widget _builder(BuildContext context, TasksState state) {
    if (state is LoadingState) {
      return const LoadingBlocWidget('Loading tasks...');
    }
    if (state is ErrorState) {
      return const ErrorBlocWidget(
        callback: null,
        icon: MdiIcons.accessPointNetworkOff,
        message: 'Connection failed',
      );
    }
    if (state is SuccessState) {
      if (state is TaskListFetchedState) {
        return TaskListView(
          height: double.infinity,
          width: double.infinity,
          tasks: state.tasks,
        );
      }
    }
    context
        .bloc<TasksBloc>()
        .add(const FetchAllForProjectEvent(projectId: 1, isActive: true));
    return const InitialBlocWidget();
  }

  void _listener(BuildContext context, TasksState state) {}

  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }
}
