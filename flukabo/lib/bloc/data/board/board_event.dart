part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class FetchBoard extends BoardEvent {
  final int projectId;
  const FetchBoard({this.projectId});

  @override
  List<Object> get props => [projectId];
}
