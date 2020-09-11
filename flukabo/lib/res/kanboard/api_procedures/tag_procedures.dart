///
/// Tag API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/tags_procedures.html
///
/// [TagProcedures] enum of all the used API methods
/// [tagCommands] map from [TagProcedures] -> actual api command
///
enum TagProcedures {
  create,
  getByProject,
  getByTask,
  getAll,
  update,
  remove,
  assign,
}

const Map<TagProcedures, String> tagCommands = {
  TagProcedures.create: 'createTag',
  TagProcedures.getByProject: 'getTagsByProject',
  TagProcedures.getByTask: 'getTaskTags',
  TagProcedures.getAll: 'getAllTags',
  TagProcedures.update: 'updateTag',
  TagProcedures.remove: 'removeTag',
  TagProcedures.assign: 'setTaskTags',
};
