import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bloc_commons.dart';

///
/// An error icon, with a prompt notifying the user that there was some error,
/// and a retry button that will trigger [callback] upon clicking
///
class BoardBlocErrorWidget extends StatelessWidget {
  final void Function(BuildContext) callback;
  const BoardBlocErrorWidget(this.callback);

  @override
  Widget build(BuildContext context) {
    return ErrorBlocWidget(
      callback: callback,
      icon: MdiIcons.downloadOff,
      message: 'Uh oh... Board fetching failed...',
    );
  }
}

/// A loading indicator with 'Fetching projects...' underneath it
class BoardBlocLoadingWidget extends StatelessWidget {
  const BoardBlocLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const LoadingBlocWidget('Fetching board');
  }
}

/// A centered text widget letting the user know there is no content
class BoardBlocEmptyContentWidget extends StatelessWidget {
  const BoardBlocEmptyContentWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Nothing to see here'));
  }
}
