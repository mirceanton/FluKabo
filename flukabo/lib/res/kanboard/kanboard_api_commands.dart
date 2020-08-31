///
/// Application API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/application_procedures.html
///
/// [ApplicationProcedures] enum of all the used API methods
/// [kanboardCommands] map from [ApplicationProcedures] -> actual api command
///
enum ApplicationProcedures {
  version,
  timezone,
  applicationRoles,
  projectRoles,
  defaultTaskColor,
}

const Map<ApplicationProcedures, String> kanboardCommands = {
  ApplicationProcedures.version: 'getVersion',
  ApplicationProcedures.timezone: 'getTimezone',
  ApplicationProcedures.defaultTaskColor: 'getDefaultTaskColor',
  ApplicationProcedures.applicationRoles: 'getApplicationRoles',
  ApplicationProcedures.projectRoles: 'getProjectRoles',
};

///
/// ------------
///

///
/// Application API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/application_procedures.html
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
