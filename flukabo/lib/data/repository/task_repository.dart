import '../models/task.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// tasks management
///
/// It includes the following functionality:
///   - Task creation
///   - Task update
///   - Task removal
///   - Individual Task retrieval (based on either reference or id)
///   - Bulk Tasks retrieval (all, all overdue, overdue by project)
///   - Task open/close
///
class TaskRepository {
  static final TaskRepository _instance = TaskRepository._constructor();

  factory TaskRepository() => _instance;
  TaskRepository._constructor(); // empty constructor

}
