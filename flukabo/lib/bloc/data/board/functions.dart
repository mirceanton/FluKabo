import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/board/board_bloc.dart';
import '../../../ui/commons.dart';
import '../../../ui/templates/bloc_widgets/bloc_commons.dart';
import '../../../ui/templates/bloc_widgets/board_bloc_widgets.dart';

void listener(BuildContext context, BoardState state) {
  if (state is BoardError) {
    showSnackbar(context: context, content: state.errmsg);
  }
}

Widget builder(
  BuildContext context,
  BoardState state, {
  @required FetchBoard defaultEvent,
  @required Widget Function(BuildContext, BoardState) successBuilder,
}) {
  if (state is BoardLoading) {
    print('Loading board...');
    return const BoardBlocLoadingWidget();
  }

  if (state is BoardError) {
    print("Board error");
    return BoardBlocErrorWidget(
      (context) => context.bloc<BoardBloc>().add(defaultEvent),
    );
  }

  if (state is BoardLoaded) {
    return successBuilder(context, state);
  }
  context.bloc<BoardBloc>().add(defaultEvent);
  return const InitialBlocWidget();
}

Widget boardBuilder(BuildContext context, BoardState state) {
  return Container();
}
