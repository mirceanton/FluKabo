///
/// This is a singleton meant to encapsulate all the methods associated with
/// task link management
///
/// It includes the following functionality:
///   - Create new Link
///   - Retrieve Link
///     - By Id
///   - Retrieve All Links
///   - Update Link
///   - Remove Link
///
class TaskLinkRepository {
  static final TaskLinkRepository _instance = TaskLinkRepository._constructor();

  factory TaskLinkRepository() => _instance;
  TaskLinkRepository._constructor(); // empty constructor
}
