import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bloc_commons.dart';

/// An error icon, with contextual information and a retry button
class ProjectBlocErrorWidget extends StatelessWidget {
  final void Function(BuildContext) callback;
  const ProjectBlocErrorWidget(this.callback);

  @override
  Widget build(BuildContext context) {
    return ErrorBlocWidget(
      callback: callback,
      icon: MdiIcons.downloadOff,
      message: 'Connection failed',
    );
  }
}

/// A loading indicator with some info text underneath
class ProjectBlocLoadingWidget extends StatelessWidget {
  const ProjectBlocLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const LoadingBlocWidget('Fetching projects');
  }
}
