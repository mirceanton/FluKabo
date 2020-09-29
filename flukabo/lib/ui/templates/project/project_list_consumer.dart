import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/projects/events/events.dart';
import '../../../bloc/data/projects/functions.dart';
import '../../../bloc/data/projects/projects_bloc.dart';

import '../../../res/dimensions.dart';

/// A generic implementation of [BlocConsumer] that implements the custom
/// builder and listener from the bloc/functions file, with a custom
/// [successBuilder] and [defaultEvent]
class GenericListBlocConsumer extends StatelessWidget {
  final Widget Function(BuildContext, ProjectsState) customBuilder;
  final ReadProjectEvent defaultEvent;
  const GenericListBlocConsumer({
    @required this.customBuilder,
    @required this.defaultEvent,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsBloc, ProjectsState>(
      listener: listener,
      builder: (context, state) => builder(
        context,
        state,
        defaultEvent: defaultEvent,
        successBuilder: customBuilder,
      ),
    );
  }
}

/// A vertical scrolling list with starred projects in the TileLayout
class ProjectTileListBlocConsumer extends StatelessWidget {
  final ReadProjectEvent defaultEvent;
  const ProjectTileListBlocConsumer(this.defaultEvent);

  @override
  Widget build(BuildContext context) {
    return GenericListBlocConsumer(
      customBuilder: tileListBuilder,
      defaultEvent: defaultEvent,
    );
  }
}

/// A horizontal scrolling list with starred projects in the CardLayout
class ProjectCardListBlocConsumer extends StatelessWidget {
  final ReadProjectEvent defaultEvent;
  const ProjectCardListBlocConsumer(this.defaultEvent);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: GenericListBlocConsumer(
        customBuilder: cardListBuilder,
        defaultEvent: defaultEvent,
      ),
    );
  }
}
