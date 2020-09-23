import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flukabo/data/models/board.dart';
import 'package:flukabo/data/repository/board_repository.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';

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
        yield BoardLoaded(
          board: await BoardRepository().getBoardForProject(event.projectId),
        );
      }
    } on Failure catch (f) {
      yield BoardError(message: f.message);
    }
  }
}
