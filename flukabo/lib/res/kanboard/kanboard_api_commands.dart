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

///
/// ------------
///

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

///
/// ------------
///

///
/// Members API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/group_member_procedures.html
///
/// [MembersProcedures] enum of all the used API methods
/// [membersCommands] map from [MembersProcedures] -> actual api command
///
enum MembersProcedures {
  getGroups,
  getMembers,
  addToGroup,
  removeFromGroup,
  isInGroup,
}

const Map<MembersProcedures, String> membersCommands = {
  MembersProcedures.getGroups: 'getMemberGroups',
  MembersProcedures.getMembers: 'getGroupMembers',
  MembersProcedures.addToGroup: 'addGroupMember',
  MembersProcedures.removeFromGroup: 'removeGroupMember',
  MembersProcedures.isInGroup: 'isGroupMember',
};
