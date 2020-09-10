///
/// Group API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/comment_procedures.html
///
/// [CommentProcedures] enum of all the used API methods
/// [commentCommands] map from [CommentProcedures] -> actual api command
///
enum CommentProcedures {
  create,
  getById,
  getAll,
  update,
  remove,
}

const Map<CommentProcedures, String> commentCommands = {
  CommentProcedures.create: 'createComment',
  CommentProcedures.getById: 'getComment',
  CommentProcedures.getAll: 'getAllComments',
  CommentProcedures.update: 'updateComment',
  CommentProcedures.remove: 'removeComment',
};
