///
/// This is a singleton meant to encapsulate all the methods associated with
/// the tags management functionality provided by the web app.
///
/// It includes the following functionality:
///   - Create tag
///   - Get tag
///     - by project
///     - by task
///     - all
///   - Update tag
///   - Remove tag
///   - Link tag to task
///
class TagRepository {
  static final TagRepository _instance = TagRepository._constructor();

  factory TagRepository() => _instance;
  TagRepository._constructor(); // empty constructor
}
