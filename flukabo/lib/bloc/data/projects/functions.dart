import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/dimensions.dart';

import '../../../ui/commons.dart';
import '../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../ui/templates/bloc_widgets/projects_bloc_widgets.dart';
import '../../../ui/templates/project/project_list_view.dart';

import './events/events.dart';
import './projects_bloc.dart';
import './states/states.dart';

/// [listener] handles showing a snackbar if the state is [ProjectError]
void listener(BuildContext context, ProjectsState state) {
  if (state is ProjectError) {
    showSnackbar(context: context, content: state.errmsg);
  }
}

Widget cardListBuilder(BuildContext context, ProjectsState state) {
  if (state is ProjectListFetched) {
    if (state.projects.isEmpty) {
      return const ProjectBlocEmptyContentWidget();
    } else {
      return ProjectListView(
        height: cardHeight,
        width: double.infinity,
        projects: state.projects,
        showCards: true,
      );
    }
  }
  return const SizedBox(width: 0, height: 0);
}

Widget tileListBuilder(BuildContext context, ProjectsState state) {
  if (state is ProjectListFetched) {
    if (state.projects.isEmpty) {
      return const ProjectBlocEmptyContentWidget();
    } else {
      return ProjectListView(
        height: double.infinity,
        width: double.infinity,
        projects: state.projects,
        showCards: false,
      );
    }
  }
  return const SizedBox(height: 0, width: 0);
}

Widget builder(
  BuildContext context,
  ProjectsState state, {
  @required ReadEvent defaultEvent,
  @required Widget Function(BuildContext, ProjectsState) successBuilder,
}) {
  if (state is ProjectLoading) {
    print('Projects loading...');
    return const ProjectBlocLoadingWidget();
  }
  if (state is ProjectError) {
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
