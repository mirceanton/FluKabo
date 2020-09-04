///
/// Column API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/group_procedures.html
///
/// [ColumnProcedures] enum of all the used API methods
/// [columnCommands] map from [ColumnProcedures] -> actual api command
///
enum ColumnProcedures {
  create,
  update,
  remove,
  get,
  getAll,
  relocate,
}

const Map<ColumnProcedures, String> columnCommands = {
  ColumnProcedures.create: 'addColumn',
  ColumnProcedures.update: 'updateColumn',
  ColumnProcedures.remove: 'removeColumn',
  ColumnProcedures.get: 'getColumn',
  ColumnProcedures.getAll: 'getColumns',
  ColumnProcedures.relocate: 'changeColumnPosition',
};
