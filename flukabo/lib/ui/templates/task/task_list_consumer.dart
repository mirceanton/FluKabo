import 'package:flukabo/bloc/data/tasks/events/events.dart';
import 'package:flukabo/bloc/data/tasks/functions.dart';
import 'package:flukabo/bloc/data/tasks/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// A vertical scrolling list with tasks assigned to the current user in
/// ListTile Layout
///
class YourTasksTileListBlocConsumer extends StatelessWidget {
  const YourTasksTileListBlocConsumer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: listener,
        builder: (context, state) => builder(
          context,
          state,
          defaultEvent: const FetchAllTasksForProject(
            projectId: 1,
            isActive: true,
          ), // FIXME
          successBuilder: taskListBuilder,
        ),
      ),
    );
  }
}
