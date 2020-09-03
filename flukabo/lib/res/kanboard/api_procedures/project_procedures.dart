///
/// Project API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/project_procedures.html
///
/// [ProjectProcedures] enum of all the used API methods
/// [projectCommands] map from [ProjectProcedures] -> actual api command
///
enum ProjectProcedures {
  create,
  getById,
  getByName,
  getAll,
  update,
  remove,
  enable,
  disable,
  enablePublicAccess,
  disablePublicAccess,
  getActivity
}

const Map<ProjectProcedures, String> projectCommands = {
  ProjectProcedures.create: 'createProject',
  ProjectProcedures.getById: 'getProjectById',
  ProjectProcedures.getByName: 'getProjectByName',
  ProjectProcedures.getAll: 'getAllProjects',
  ProjectProcedures.update: 'updateProject',
  ProjectProcedures.remove: 'removeProject',
  ProjectProcedures.enable: 'enableProject',
  ProjectProcedures.disable: 'disableProject',
  ProjectProcedures.enablePublicAccess: 'enableProjectPublicAccess',
  ProjectProcedures.disablePublicAccess: 'disableProjectPublicAccess',
  ProjectProcedures.getActivity: 'getProjectActivity'
};

///
/// Project Permissions API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/project_permission_procedures.html
///
/// [ProjectPermissionProcedures] enum of all the used API methods
/// [projectPermissionCommands] map from [ProjectPermissionProcedures]
///     -> actual api command
///
enum ProjectPermissionProcedures {
  getUsers,
  getAssignableUsers,
  addUser,
  addGroup,
  removeUser,
  removeGroup,
  changeUserRole,
  changeGroupRole,
  getUserRole,
}

const Map<ProjectPermissionProcedures, String> projectPermissionCommands = {
  ProjectPermissionProcedures.getUsers: 'getProjectUsers',
  ProjectPermissionProcedures.getAssignableUsers: 'getAssignableUsers',
  ProjectPermissionProcedures.addUser: 'addProjectUser',
  ProjectPermissionProcedures.addGroup: 'addProjectGroup',
  ProjectPermissionProcedures.removeUser: 'removeProjectUser',
  ProjectPermissionProcedures.removeGroup: 'removeProjectGroup',
  ProjectPermissionProcedures.changeUserRole: 'changeProjectUserRole',
  ProjectPermissionProcedures.changeGroupRole: 'changeProjectGroupRole',
  ProjectPermissionProcedures.getUserRole: 'getProjectUserRole',
};

///
/// Project Metadata API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/project_metadata_procedures.html
///
/// [ProjectMetadataProcedures] enum of all the used API methods
/// [projectMetadataCommands] map from [ProjectMetadataProcedures]
///     -> actual api command
///
enum ProjectMetadataProcedures {
  getAll,
  getByKey,
  add,
  remove,
  update,
}

const Map<ProjectMetadataProcedures, String> projectMetadataCommands = {
  ProjectMetadataProcedures.getAll: 'getProjectMetadata',
  ProjectMetadataProcedures.getByKey: 'getProjectMetadataByName',
  ProjectMetadataProcedures.add: 'saveProjectMetadata',
  ProjectMetadataProcedures.remove: 'removeProjectMetadata',
};
