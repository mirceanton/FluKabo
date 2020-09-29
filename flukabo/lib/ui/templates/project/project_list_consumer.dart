import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/projects/events/events.dart';
import '../../../bloc/data/projects/functions.dart';
import '../../../bloc/data/projects/projects_bloc.dart';

import '../../../res/dimensions.dart';

/// A vertical scrolling list with starred projects in the TileLayout
class ProjectTileListBlocConsumer extends StatelessWidget {
  const ProjectTileListBlocConsumer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<ProjectsBloc, ProjectsState>(
        listener: listener,
        builder: (context, state) => builder(
          context,
          state,
          defaultEvent: const FetchAllProjects(),
          successBuilder: tileListBuilder,
        ),
      ),
    );
  }
}

/// A horizontal scrolling list with starred projects in the CardLayout
class ProjectCardListBlocConsumer extends StatelessWidget {
  const ProjectCardListBlocConsumer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: BlocConsumer<ProjectsBloc, ProjectsState>(
        listener: listener,
        builder: (context, state) => builder(
          context,
          state,
          defaultEvent: const FetchAllProjects(),
          successBuilder: cardListBuilder,
        ),
      ),
    );
  }
}
