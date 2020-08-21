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
