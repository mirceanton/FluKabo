import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bloc_commons.dart';

///
/// An error icon, with a prompt notifying the user that there was some error,
/// and a retry button that will trigger [callback] upon clicking
///
class TaskBlocErrorWidget extends StatelessWidget {
  final void Function(BuildContext) callback;
  const TaskBlocErrorWidget(this.callback);

  @override
  Widget build(BuildContext context) {
    return ErrorBlocWidget(
      callback: callback,
      icon: MdiIcons.downloadOff,
      message: 'Uh oh... Task fetching failed...',
    );
  }
}

/// A loading indicator with 'Fetching tasks...' underneath it
class TaskBlocLoadingWidget extends StatelessWidget {
  const TaskBlocLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const LoadingBlocWidget('Fetching tasks');
  }
}

/// A centered text widget letting the user know there is no content
class TaskBlocEmptyContentWidget extends StatelessWidget {
  const TaskBlocEmptyContentWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Nothing to see here'));
  }
}
