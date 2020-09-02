///
/// User API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/user_procedures.html
///
/// [UserProcedures] enum of all the used API methods
/// [userCommands] map from [UserProcedures] -> actual api command
///
enum UserProcedures {
  create,
  getById,
  getByName,
  getAll,
  update,
  remove,
  enable,
  disable,
  isActive,
}

const Map<UserProcedures, String> userCommands = {
  UserProcedures.create: 'createUser',
  UserProcedures.getById: 'getUser',
  UserProcedures.getByName: 'getUserByName',
  UserProcedures.getAll: 'getAllUsers',
  UserProcedures.update: 'updateUser',
  UserProcedures.remove: 'removeUser',
  UserProcedures.enable: 'enableUser',
  UserProcedures.disable: 'disableUser',
  UserProcedures.isActive: 'isActiveUser',
};
