import 'package:flukabo/bloc/data/projects/events/events.dart'
    as project_events;
import 'package:flukabo/bloc/data/projects/states/states.dart'
    as project_states;
import 'package:flukabo/bloc/data/projects/projects_bloc.dart';
import 'package:flukabo/bloc/data/tasks/events/events.dart' as task_events;
import 'package:flukabo/bloc/data/tasks/states/states.dart' as task_states;
import 'package:flukabo/bloc/data/tasks/tasks_bloc.dart';
import 'package:flukabo/res/dimensions.dart';
import 'package:flukabo/ui/commons.dart';
import 'package:flukabo/ui/templates/project/project_list_view.dart';
import 'package:flukabo/ui/templates/task/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'abstract_tab_class.dart';

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
  void _projectsListener(BuildContext context, ProjectsState state) {}
  void _taskListener(BuildContext context, TasksState state) {}

  Widget _projectsBuilder(BuildContext context, ProjectsState state) {
    if (state is project_states.LoadingState) {
      return buildLoading();
    } else if (state is project_states.ErrorState) {
      return buildError(
        context,
        icon: MdiIcons.accessPointNetworkOff,
        message: 'Connection failed',
        onButtonPress: () => retryAuth(context),
      );
    } else if (state is project_states.SuccessState) {
      if (state is project_states.ProjectListFetchedState) {
        if (state.projects.isEmpty) {
          return const Center(child: Text('No projects to show'));
        } else {
          return ProjectListView(
            height: cardHeight,
            width: double.infinity,
            projects: state.projects,
            showCards: true,
          );
        }
      }
    }
    // if the state is InitState, attempt a Fetch Event
    context.bloc<ProjectsBloc>().add(const project_events.FetchAllEvent());
    return buildInitial();
  }

  Widget _tasksBuilder(BuildContext context, TasksState state) {
    if (state is task_states.LoadingState) {
      return buildLoading();
    }
    if (state is task_states.ErrorState) {
      return buildError(
        context,
        icon: MdiIcons.accessPointNetworkOff,
        message: 'Connection failed',
        onButtonPress: () => retryAuth(context),
      );
    }
    if (state is task_states.SuccessState) {
      if (state is task_states.TaskListFetchedState) {
        if (state.tasks.isEmpty) {
          return const Center(child: Text('No tasks to show'));
        } else {
          return TaskListView(
            height: double.infinity,
            width: double.infinity,
            tasks: state.tasks,
          );
        }
      }
    }
    context.bloc<TasksBloc>().add(const task_events.FetchAllOverdueEvent());
    return buildInitial();
  }

  @override
  Widget buildContent() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectsBloc()),
        BlocProvider(create: (context) => TasksBloc()),
      ],
      child: Column(
        children: [
          const SectionTitle(title: 'Starred Projects'),
          Container(
            height: cardHeight,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: BlocConsumer<ProjectsBloc, ProjectsState>(
              listener: _projectsListener,
              builder: _projectsBuilder,
            ),
          ),
          const Divider(height: 0.5),
          const SectionTitle(title: 'Your Tasks'),
          Expanded(
            child: BlocConsumer<TasksBloc, TasksState>(
              listener: _taskListener,
              builder: _tasksBuilder,
            ),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36,
      padding: const EdgeInsets.all(8.0),
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
