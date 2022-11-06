import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/tasks/events/events.dart';
import '../../../bloc/data/tasks/functions.dart';
import '../../../bloc/data/tasks/tasks_bloc.dart';

///
/// A vertical scrolling list with tasks assigned to the current user in
/// ListTile Layout
///
class TasksTileListBlocConsumer extends StatelessWidget {
  final ReadTaskEvent defaultEvent;
  const TasksTileListBlocConsumer(this.defaultEvent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: listener,
        builder: (context, state) => builder(
          context,
          state,
          defaultEvent: defaultEvent,
          successBuilder: taskListBuilder,
        ),
      ),
    );
  }
}
