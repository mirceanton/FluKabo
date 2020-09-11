///
/// This is a singleton meant to encapsulate all the methods associated with
/// the category management
///
/// It includes the following functionality:
///   - Create Category
///   - Update Category
///   - Remove Category
///   - Individual Category retrieval based on id
///   - Bulk Category retrieval based on task id
///
class CategoryRepository {
  static final CategoryRepository _instance = CategoryRepository._constructor();

  factory CategoryRepository() => _instance;
  CategoryRepository._constructor(); // empty constructor

}
