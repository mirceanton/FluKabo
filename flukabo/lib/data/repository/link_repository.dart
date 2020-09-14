///
/// This is a singleton meant to encapsulate all the methods associated with
/// link management
///
/// It includes the following functionality:
///   - Create new Link
///   - Retrieve Link
///     - By Id
///     - By Label
///     - By Opposite
///   - Retrieve All Links
///   - Update Link
///   - Remove Link
///
class LinkRepository {
  static final LinkRepository _instance = LinkRepository._constructor();

  factory LinkRepository() => _instance;
  LinkRepository._constructor(); // empty constructor
}
