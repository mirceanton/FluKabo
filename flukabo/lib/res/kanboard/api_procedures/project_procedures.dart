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
