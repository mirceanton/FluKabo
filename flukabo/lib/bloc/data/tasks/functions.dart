import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/commons.dart';
import '../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../ui/templates/bloc_widgets/task_bloc_widgets.dart';
import './events/events.dart';
import './states/states.dart';
import './tasks_bloc.dart';

void listener(BuildContext context, TasksState state) {
  if (state is ErrorState) {
    showSnackbar(context: context, content: state.errmsg);
  }
}

Widget builder(
  BuildContext context,
  TasksState state, {
  @required ReadEvent defaultEvent,
  @required Widget Function(BuildContext, TasksState) successBuilder,
}) {
  if (state is LoadingState) {
    print('Tasks loading...');
    return const TaskBlocLoadingWidget();
  }
  if (state is ErrorState) {
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
