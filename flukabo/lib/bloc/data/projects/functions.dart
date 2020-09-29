import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/commons.dart';
import '../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../ui/templates/bloc_widgets/projects_bloc_widgets.dart';

import './events/events.dart';
import './projects_bloc.dart';
import './states/states.dart';

/// [listener] handles showing a snackbar if the state is [ProjectError]
void listener(BuildContext context, ProjectsState state) {
  if (state is ErrorState) {
    showSnackbar(context: context, content: state.errmsg);
  }
}

Widget builder(
  BuildContext context,
  ProjectsState state, {
  @required ReadEvent defaultEvent,
  @required Widget Function(BuildContext, ProjectsState) successBuilder,
}) {
  if (state is LoadingState) {
    print('Projects loading...');
    return const ProjectBlocLoadingWidget();
  }
  if (state is ErrorState) {
    print('Projects error');
    return ProjectBlocErrorWidget(
      (context) => context.bloc<ProjectsBloc>().add(defaultEvent),
    );
  }
  if (state is SuccessState) {
    return successBuilder(context, state);
  }

  // if the state is InitState, attempt a Fetch Event
  context.bloc<ProjectsBloc>().add(defaultEvent);
  return const InitialBlocWidget();
}
