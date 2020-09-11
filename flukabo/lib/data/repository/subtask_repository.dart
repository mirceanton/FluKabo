///
/// This is a singleton meant to encapsulate all the methods associated with
/// the subtask management
///
/// It includes the following functionality:
///   - Create Subtask
///   - Update Subtask
///   - Remove Subtask
///   - Individual Subtask retrieval based on id
///   - Bulk Subtask retrieval based on task id
///
class SubtaskRepository {
  static final SubtaskRepository _instance = SubtaskRepository._constructor();

  factory SubtaskRepository() => _instance;
  SubtaskRepository._constructor(); // empty constructor
}
