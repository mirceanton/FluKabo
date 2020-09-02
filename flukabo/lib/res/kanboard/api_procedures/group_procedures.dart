///
/// Group API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/group_procedures.html
///
/// [GroupProcedures] enum of all the used API methods
/// [groupCommands] map from [GroupProcedures] -> actual api command
///
enum GroupProcedures {
  create,
  update,
  remove,
  get,
  getAll,
}

const Map<GroupProcedures, String> groupCommands = {
  GroupProcedures.create: 'createGroup',
  GroupProcedures.get: 'getGroup',
  GroupProcedures.getAll: 'getAllGroups',
  GroupProcedures.update: 'updateGroup',
  GroupProcedures.remove: 'removeGroup',
};
