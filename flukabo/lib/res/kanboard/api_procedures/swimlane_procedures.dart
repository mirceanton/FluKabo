///
/// Swimlane API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/swimlane_procedures.html
///
/// [SwimlaneProcedures] enum of all the used API methods
/// [swimlaneCommands] map from [SwimlaneProcedures] -> actual api command
///
enum SwimlaneProcedures {
  create,
  getActive,
  getAll,
  getById,
  getByName,
  changePosition,
  update,
  remove,
  disable,
  enable,
}

const Map<SwimlaneProcedures, String> swimlaneCommands = {
  SwimlaneProcedures.create: 'addSwimlane',
  SwimlaneProcedures.getActive: 'getActiveSwimlanes',
  SwimlaneProcedures.getAll: 'getAllSwimlanes',
  SwimlaneProcedures.getById: 'getSwimlaneById',
  SwimlaneProcedures.getByName: 'getSwimlaneByName',
  SwimlaneProcedures.changePosition: 'changeSwimlanePosition',
  SwimlaneProcedures.update: 'updateSwimlane',
  SwimlaneProcedures.remove: 'removeSwimlane',
  SwimlaneProcedures.disable: 'disableSwimlane',
  SwimlaneProcedures.enable: 'enableSwimlane',
};
