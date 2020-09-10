///
/// This is a singleton meant to encapsulate all the methods associated with
/// the comment management
///
/// It includes the following functionality:
///   - Create Comment
///   - Update Comment
///   - Remove Comment
///   - Individual Comment retrieval based on id
///   - Bulk Comment retrieval based on task id
///
class CommentRepository {
  static final CommentRepository _instance = CommentRepository._constructor();

  factory CommentRepository() => _instance;
  CommentRepository._constructor(); // empty constructor

}
