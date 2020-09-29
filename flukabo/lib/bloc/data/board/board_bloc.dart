import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/board.dart';
import '../../../data/repository/board_repository.dart';
import '../../../data/singletons/kanboard_api_client.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(const BoardInitial());

  @override
  Stream<BoardState> mapEventToState(
    BoardEvent event,
  ) async* {
    yield const BoardLoading();
    try {
      if (event is FetchBoard) {
        final BoardModel board =
            await BoardRepository().getBoardForProject(event.projectId);
        for (int i = 0; i < board.swimlanes.length; i++) {
          for (int j = 0; j < board.swimlanes[i].columnsCount; j++) {
            for (int k = 0; k < board.swimlanes[i].columns[j].tasksCount; k++) {
              await board.swimlanes[i].columns[j].tasks[k].init();
            }
          }
        }
        yield BoardLoaded(board: board);
      }
    } on Failure catch (f) {
      yield BoardError(message: f.message);
    }
  }
}
