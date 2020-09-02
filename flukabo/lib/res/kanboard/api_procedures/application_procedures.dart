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
