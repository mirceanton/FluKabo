import 'package:flukabo/bloc/data/projects/events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/data/projects/functions.dart' as project;
import '../../../../bloc/data/projects/projects_bloc.dart';

import '../../../../bloc/data/tasks/events/events.dart' as task_events;
import '../../../../bloc/data/tasks/states/states.dart' as task_states;
import '../../../../bloc/data/tasks/tasks_bloc.dart';

import '../../../../res/dimensions.dart';

import '../../../../ui/templates/bloc_widgets/auth_bloc_widgets.dart';
import '../../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../../ui/templates/task/task_list_view.dart';

import 'abstract_tab_class.dart';

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
            margin: const EdgeInsets.only(bottom: 8.0),
            child: BlocConsumer<ProjectsBloc, ProjectsState>(
              listener: project.listener,
              builder: (context, state) => project.builder(
                context,
                state,
                defaultEvent: const FetchAllEvent(),
                showCards: true,
              ),
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
