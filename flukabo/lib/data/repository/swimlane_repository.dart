///
/// This is a singleton meant to encapsulate all the methods associated with
/// the Swimlane management
///
/// It includes the following functionality:
///   - Create Swimlane
///   - Update Swimlane
///   - Change the position of a Swimlane
///   - Remove Swimlane
///   - Individual Swimlane retrieval (by id, by name)
///   - Bulk Swimlane retrieval (all, active)
///   - Swimlane enable/disable
///
class SwimlaneRepository {
  static final SwimlaneRepository _instance = SwimlaneRepository._constructor();

  factory SwimlaneRepository() => _instance;
  SwimlaneRepository._constructor(); // empty constructor
}
