///
/// Category API Procedures
/// doc: https://docs.kanboard.org/en/latest/api/category_procedures.html
///
/// [CategoryProcedures] enum of all the used API methods
/// [categoryCommands] map from [CategoryProcedures] -> actual api command
///
enum CategoryProcedures {
  create,
  getById,
  getAll,
  update,
  remove,
}

const Map<CategoryProcedures, String> categoryCommands = {
  CategoryProcedures.create: 'createCategory',
  CategoryProcedures.getById: 'getCategory',
  CategoryProcedures.getAll: 'getAllCategories',
  CategoryProcedures.update: 'updateCategory',
  CategoryProcedures.remove: 'removeCategory',
};
