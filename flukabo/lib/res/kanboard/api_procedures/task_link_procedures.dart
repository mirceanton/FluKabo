///
/// Task Link API Procedures
/// doc:https://docs.kanboard.org/en/latest/api/internal_task_link_procedures.html
///
/// [TaskLinkProcedures] enum of all the used API methods
/// [tasklinkCommands] map from [TaskLinkProcedures] -> actual api command
///
enum TaskLinkProcedures {
  create,
  getById,
  getAll,
  update,
  remove,
}

const Map<TaskLinkProcedures, String> taskLinkCommands = {
  TaskLinkProcedures.create: 'createTaskLink',
  TaskLinkProcedures.getById: 'getTaskLinkById',
  TaskLinkProcedures.getAll: 'getAllTaskLinks',
  TaskLinkProcedures.update: 'updateTaskLink',
  TaskLinkProcedures.remove: 'removeTaskLink',
};
