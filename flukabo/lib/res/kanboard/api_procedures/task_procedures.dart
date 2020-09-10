///
/// Task API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/task_procedures.html
///
/// [TaskProcedures] enum of all the used API methods
/// [taskCommands] map from [TaskProcedures] -> actual api command
///
enum TaskProcedures {
  create,
  getById,
  getByReference,
  getAll,
  getAllOverdue,
  getOverdueByProject,
  update,
  remove,
  open,
  close,
  moveToPosition,
  moveToProject,
  cloneToProject,
  search,
}

const Map<TaskProcedures, String> taskCommands = {
  TaskProcedures.create: 'createTask',
  TaskProcedures.getById: 'getTask',
  TaskProcedures.getByReference: 'getTaskByReference',
  TaskProcedures.getAll: 'getAllTasks',
  TaskProcedures.getAllOverdue: 'getOverdueTasks',
  TaskProcedures.getOverdueByProject: 'getOverdueTasksByProject',
  TaskProcedures.update: 'updateTask',
  TaskProcedures.remove: 'removeTask',
  TaskProcedures.open: 'openTask',
  TaskProcedures.close: 'closeTask',
  TaskProcedures.moveToPosition: 'moveTaskPosition',
  TaskProcedures.moveToProject: 'moveTaskToProject',
  TaskProcedures.cloneToProject: 'duplicateTaskToProject',
  TaskProcedures.search: 'searchTasks',
};
