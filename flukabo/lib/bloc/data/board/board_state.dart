part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

class BoardInitial extends BoardState {
  const BoardInitial();

  @override
  List<Object> get props => [];
}

class BoardLoading extends BoardState {
  const BoardLoading();

  @override
  List<Object> get props => [];
}

class BoardError extends BoardState {
  final String message;
  const BoardError({this.message});

  @override
  List<Object> get props => [message];
}

class BoardLoaded extends BoardState {
  final BoardModel board;
  const BoardLoaded({this.board});

  @override
  List<Object> get props => [board];
}
