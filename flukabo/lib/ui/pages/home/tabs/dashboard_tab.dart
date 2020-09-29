import 'package:flukabo/bloc/data/projects/events/events.dart';
import 'package:flukabo/bloc/data/projects/projects_bloc.dart';
import 'package:flukabo/bloc/data/projects/states/error_state.dart';
import 'package:flukabo/bloc/data/projects/states/states.dart';
import 'package:flukabo/bloc/data/tasks/events/events.dart' as task_events;
import 'package:flukabo/bloc/data/tasks/states/states.dart' as task_states;
import 'package:flukabo/bloc/data/tasks/tasks_bloc.dart';
import 'package:flukabo/res/dimensions.dart';
import 'package:flukabo/ui/templates/bloc_widgets/auth_bloc_widgets.dart';
import 'package:flukabo/ui/templates/bloc_widgets/bloc_commons.dart';
import 'package:flukabo/ui/templates/project/project_list_view.dart';
import 'package:flukabo/ui/templates/task/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons.dart';
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
  void _taskListener(BuildContext context, TasksState state) {}
  Widget _tasksBuilder(BuildContext context, TasksState state) {
    if (state is task_states.LoadingState) {
      return const InitialBlocWidget();
    }
    if (state is task_states.ErrorState) {
      return const AuthBlocErrorWidget();
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
    return const InitialBlocWidget();
  }

  void projectsListener(BuildContext context, ProjectsState state) {
    if (state is ErrorState) {
      showSnackbar(context: context, content: state.errmsg);
    }
  }

  Widget projectsBuilder(BuildContext context, ProjectsState state) {
    if (state is LoadingState) {
      return const LoadingBlocWidget('Loading dashboard...');
    } else if (state is ErrorState) {
      return const AuthBlocErrorWidget();
    } else if (state is SuccessState) {
      if (state is ProjectListFetchedState) {
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
    context.bloc<ProjectsBloc>().add(const FetchAllEvent());
    return const InitialBlocWidget();
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
              listener: projectsListener,
              builder: projectsBuilder,
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
