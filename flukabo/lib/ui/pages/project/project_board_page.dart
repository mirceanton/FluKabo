import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/data/board/board_bloc.dart';
import '../../../bloc/data/board/functions.dart';
import '../../../data/models/project.dart';

class ProjectBoardPage extends StatefulWidget {
  final ProjectModel _project;
  const ProjectBoardPage(this._project);

  @override
  // ignore: no_logic_in_create_state
  _ProjectBoardPageState createState() => _ProjectBoardPageState(_project);
}

class _ProjectBoardPageState extends State<ProjectBoardPage>
    with TickerProviderStateMixin {
  final ProjectModel project;
  _ProjectBoardPageState(this.project);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(),
      child: BlocConsumer<BoardBloc, BoardState>(
        listener: listener,
        builder: (context, state) => builder(
          context,
          state,
          defaultEvent: FetchBoard(projectId: project.id),
          successBuilder: boardBuilder,
        ),
      ),
    );
  }
}
