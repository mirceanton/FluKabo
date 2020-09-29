import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/commons.dart';
import '../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../ui/templates/bloc_widgets/task_bloc_widgets.dart';
import '../../../ui/templates/task/task_list_view.dart';
import './events/events.dart';
import './states/states.dart';
import './tasks_bloc.dart';

void listener(BuildContext context, TasksState state) {
  if (state is TaskError) {
    showSnackbar(context: context, content: state.errmsg);
  }
}

Widget taskListBuilder(BuildContext context, TasksState state) {
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

Widget builder(
  BuildContext context,
  TasksState state, {
  @required ReadEvent defaultEvent,
  @required Widget Function(BuildContext, TasksState) successBuilder,
}) {
  if (state is TaskLoading) {
    print('Tasks loading...');
    return const TaskBlocLoadingWidget();
  }
  if (state is TaskError) {
    print('Tasks error');
    return TaskBlocErrorWidget(
      (context) => context.bloc<TasksBloc>().add(defaultEvent),
    );
  }
  if (state is SuccessState) {
    return successBuilder(context, state);
  }
  context.bloc<TasksBloc>().add(defaultEvent);
  return const InitialBlocWidget();
}
