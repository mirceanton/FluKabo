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

///
/// Subtask Time Trackink API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/subtask_procedures.html
///
/// [TimeProcedures] enum of all the used API methods
/// [timeCommands] map from [TimeProcedures] -> actual api command
///
enum TimeProcedures {
  startTimer,
  stopTimer,
  hasTimer,
  getTime,
}

const Map<TimeProcedures, String> timeCommands = {
  TimeProcedures.startTimer: 'setSubtaskStartTime',
  TimeProcedures.stopTimer: 'setSubtaskEndTime',
  TimeProcedures.hasTimer: 'hasSubtaskTimer',
  TimeProcedures.getTime: 'getSubtaskTimeSpent',
};
