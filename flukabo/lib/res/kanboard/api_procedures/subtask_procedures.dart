///
/// Subtask API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/subtask_procedures.html
///
/// [SubtaskProcedures] enum of all the used API methods
/// [subtaskCommands] map from [SubtaskProcedures] -> actual api command
///
enum SubtaskProcedures {
  create,
  getById,
  getAll,
  update,
  remove,
}

const Map<SubtaskProcedures, String> subtaskCommands = {
  SubtaskProcedures.create: 'createSubtask',
  SubtaskProcedures.getById: 'getSubtask',
  SubtaskProcedures.getAll: 'getAllSubtasks',
  SubtaskProcedures.update: 'updateSubtask',
  SubtaskProcedures.remove: 'removeSubtask',
};
