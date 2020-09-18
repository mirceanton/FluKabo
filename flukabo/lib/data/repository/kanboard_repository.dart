import '../../data/singletons/kanboard_api_client.dart';
import '../../res/kanboard/api_procedures/application_procedures.dart';

///
/// This is a singleton meant to encapsulate all the data associated with the
/// app running on the server, such as:
/// - app version
/// - active timezone
/// - application and project roles which are app-wide
/// - the default color given to a task
/// - a list of all of the available task colors
///
class KanboardRepository {
  static final KanboardRepository _instance = KanboardRepository._constructor();
  String version, timezone, defaultTaskColor;
  Map<String, String> applicationRoles, projectRoles;

  factory KanboardRepository() => _instance;
  KanboardRepository._constructor(); // empty constructor

  /// [init] fetches and caches all the fields
  Future<void> init() async {
    version = await KanboardAPI().getString(
      command: kanboardCommands[ApplicationProcedures.version],
      params: {},
    );
    timezone = await KanboardAPI().getString(
      command: kanboardCommands[ApplicationProcedures.timezone],
      params: {},
    );
    applicationRoles = await KanboardAPI().getMap<String, String>(
      command: kanboardCommands[ApplicationProcedures.applicationRoles],
      params: {},
    );
    projectRoles = await KanboardAPI().getMap<String, String>(
      command: kanboardCommands[ApplicationProcedures.projectRoles],
      params: {},
    );
    defaultTaskColor = await KanboardAPI().getString(
      command: kanboardCommands[ApplicationProcedures.defaultTaskColor],
      params: {},
    );
  }

  // todo DELETEME
  void display() {
    print('Version: $version');
    print('Timezone: $timezone');
    print('Default Task Color: $defaultTaskColor');
    print('Application roles: $applicationRoles');
    print('Project roles: $projectRoles');
  }
}
