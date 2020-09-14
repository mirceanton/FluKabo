///
/// Link API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/link_procedures.html
///
/// [LinkProcedures] enum of all the used API methods
/// [linkCommands] map from [LinkProcedures] -> actual api command
///
enum LinkProcedures {
  create,
  getById,
  getByLabel,
  getOpposite,
  getAll,
  update,
  remove,
}

const Map<LinkProcedures, String> linkCommands = {
  LinkProcedures.create: 'createLink',
  LinkProcedures.getById: 'getLinkById',
  LinkProcedures.getByLabel: 'getLinkByLabel',
  LinkProcedures.getOpposite: 'getOppositeLinkId',
  LinkProcedures.getAll: 'getAllLinks',
  LinkProcedures.update: 'updateLink',
  LinkProcedures.remove: 'removeLink',
};
