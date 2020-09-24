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
          return const Center(
            child: Text('No projects to show'),
          );
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
        return TaskListView(
          height: double.infinity,
          width: double.infinity,
          tasks: state.tasks,
        );
      }
    }
    context.bloc<TasksBloc>().add(
          const task_events.FetchAllForProjectEvent(
            projectId: 1,
            isActive: true,
          ),
        );
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
          Container(
            width: double.infinity,
            height: 36,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Starred projects',
              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: cardHeight,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: BlocConsumer<ProjectsBloc, ProjectsState>(
              listener: (context, state) {},
              builder: _projectsBuilder,
            ),
          ),
          const Divider(height: 0.5),
          Container(
            width: double.infinity,
            height: 36,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Your tasks',
              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                cardHeight -
                130 -
                36 -
                8 -
                36 -
                1,
            width: double.infinity,
            child: BlocConsumer<TasksBloc, TasksState>(
              listener: (context, state) {},
              builder: _tasksBuilder,
            ),
          )
        ],
      ),
    );
  }
}
