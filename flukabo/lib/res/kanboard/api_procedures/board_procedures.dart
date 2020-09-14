///
/// Board API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/board_procedures.html
///
/// [BoardProcedures] enum of all the used API methods
/// [boardCommands] map from [BoardProcedures] -> actual api command
///
enum BoardProcedures {
  getByProject,
}

const Map<BoardProcedures, String> boardCommands = {
  BoardProcedures.getByProject: 'getBoard',
};
