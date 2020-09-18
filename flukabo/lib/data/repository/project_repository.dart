import 'package:flukabo/data/models/event.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/project_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with the
/// project management feature provided to all users.
///
/// It includes the following functionality:
///   - C.R.U.D operations:
///     - Create project
///     - Read project by id
///     - Read project by name
///     - Update project
///     - Delete project
///   - Enable/Disable Project
///   - Enable/Disable Public Access
///   - Get Activity Feed
///
class ProjectRepository {
  static final ProjectRepository _instance = ProjectRepository._constructor();

  factory ProjectRepository() => _instance;
  ProjectRepository._constructor(); // empty constructor

  ///
  /// [createProject] returns the id of the newly created project if the
  /// creation was successfull. If the creation failed, an instance of Failure
  /// is thrown
  ///
  /// [name] is required as all Projects must have a name
  /// [description], [ownerId] and [identifier] are optional parameters.
  /// If no values are provided, [description] will be empty, the [ownerId] will
  /// be '0' and the [identifier] will also be empty
  ///
  /// the [id] of the newly created Project is the [statusCode] (as long as it
  /// is not 0. then if means there was an error)
  ///
  Future<int> createProject({
    @required String name,
    String description = '',
    int ownerId = 0,
    String identifier = '',
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: projectCommands[ProjectProcedures.create],
      params: {
        'name': name,
        'description': description,
        'owner_id': ownerId.toString(),
        'identifier': identifier,
      },
    );
    return statusCode;
  }

  ///
  ///[getProjectById] returns a Project object if the given id is valid
  /// or throws a Failure otherwise
  ///
  Future<ProjectModel> getProjectById(int id) async {
    final ProjectModel project = await KanboardAPI().getObject<ProjectModel>(
      command: projectCommands[ProjectProcedures.getById],
      params: {'project_id': id.toString()},
    );
    return project;
  }

  ///
  ///[getProjectByName] returns a Project object if the given name is valid
  /// or throws a Failure otherwise (also throws failure if name doesn't exist)
  ///
  Future<ProjectModel> getProjectByName(String name) async {
    final ProjectModel project = await KanboardAPI().getObject<ProjectModel>(
      command: projectCommands[ProjectProcedures.getByName],
      params: {'name': name},
    );
    return project;
  }

  ///
  /// [getAllProjects] returns a List of projects if the fetch was successfull,
  /// or it throws a Failure if the api call failed for some reason
  ///
  Future<List<ProjectModel>> getAllProjects() async {
    final List<ProjectModel> projects =
        await KanboardAPI().getObjectList<ProjectModel>(
      command: projectCommands[ProjectProcedures.getAll],
      params: {},
    );
    return projects;
  }

  ///
  /// [updateProject] returns true if the project was updated successfully or
  /// false otherwise
  ///
  /// [id] is the only required field, as this is the identifier by which we
  /// get the project which we want to update
  /// All the other fields, aka [ownerId], [name], [description] and
  /// [identifier] are completely optional and will be kept unchanged if no
  /// value is provided
  ///
  Future<bool> updateProject({
    @required int id,
    int ownerId = -1,
    String name = '',
    String description = '',
    String identifier = '',
  }) async {
    final ProjectModel project = await getProjectById(id);
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.update],
      params: {
        'project_id': id.toString(),
        'name': name.isEmpty ? project.name : name,
        'description': description.isEmpty ? project.description : description,
        'owner_id':
            ownerId == -1 ? project.ownerID.toString() : ownerId.toString(),
        'identifier': identifier.isEmpty ? project.identifier : identifier,
      },
    );
    return status;
  }

  ///
  /// [removeProject] returns true if the project was successfully removed, or
  /// false otherwise
  /// This function completely removes the project from the databse.
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeProject(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.remove],
      params: {
        'project_id': id.toString(),
      },
    );
    return status;
  }

  ///
  /// [disableProject] returns true if the project was successfully disabled,
  /// or false otherwise
  /// This function sets the project.isActive to false
  /// This can be undone via the [enableProject] function
  ///
  Future<bool> disableProject(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.disable],
      params: {'project_id': id.toString()},
    );
    return status;
  }

  ///
  /// [enableProject] returns true if the project was successfully enabled, or
  /// false otherwise
  /// This function sets the project.isActive to true
  /// This can be undone via the [disableProject] function
  ///
  Future<bool> enableProject(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.enable],
      params: {'project_id': id.toString()},
    );
    return status;
  }

  ///
  /// [disablePublicAccess] returns true if the project accessibility level
  /// was successfully changed to non-public
  /// otherwise
  /// This function sets the project.isPublic to false
  /// This can be undone via the [enablePublicAccess] function
  ///
  Future<bool> disablePublicAccess(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.disablePublicAccess],
      params: {'project_id': id.toString()},
    );
    return status;
  }

  ///
  /// [enablePublicAccess] returns true if the project accessibility level
  /// was successfully changed to public
  /// This function sets the project.isPublic to true
  /// This can be undone via the [disablePublicAccess] function
  ///
  Future<bool> enablePublicAccess(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: projectCommands[ProjectProcedures.enablePublicAccess],
      params: {'project_id': id.toString()},
    );
    return status;
  }

  ///
  /// [getAllProjects] returns a List of projects if the fetch was successfull,
  /// or it throws a Failure if the api call failed for some reason
  ///
  Future<List<EventModel>> getFeed(int id) async {
    final List<EventModel> events =
        await KanboardAPI().getObjectList<EventModel>(
      command: projectCommands[ProjectProcedures.getActivity],
      params: {'project_id': id.toString()},
    );
    return events;
  }

  ///
  /// [getProjectUsers] returns a List of all users associated with the given
  /// project (by [id]) or throws a Failure if the api call failed for some
  /// reason
  ///
  Future<List<UserModel>> getProjectUsers(int id) async {
    final List<UserModel> users = await KanboardAPI().getObjectList<UserModel>(
      command: projectPermissionCommands[ProjectPermissionProcedures.getUsers],
      params: {'project_id': id.toString()},
    );
    return users;
  }

  ///
  /// [getProjectUsers] returns a List of all users associated with the given
  /// project (by [id]) with a role higher than 'project-viewer' or throws a
  /// Failure if the api call failed for some reason
  ///
  Future<List<UserModel>> getAssignableUsers(int id) async {
    final List<UserModel> users = await KanboardAPI().getObjectList<UserModel>(
      command: projectPermissionCommands[
          ProjectPermissionProcedures.getAssignableUsers],
      params: {'project_id': id.toString()},
    );
    return users;
  }

  ///
  /// [addUserToProject] returns a true if the given user was successfully
  /// added to the given project, and false otherwise
  ///
  /// the given project is identified by the [projectId] and the user via the
  /// [userId]
  /// [role] represents the role the user has within that project, and basically
  /// sets permissions for certain actions. This value is optional, and if none
  /// is provided, the default is 'project-member' which is a
  /// middle-of-the-road permission level, granting higher priviledges compared
  /// to a 'project-viewer', but lower than a 'project-manager'
  ///
  Future<bool> addUserToProject({
    @required int projectId,
    @required int userId,
    String role = 'project-member',
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: projectPermissionCommands[ProjectPermissionProcedures.addUser],
      params: {
        'project_id': projectId.toString(),
        'user_id': userId.toString(),
        'role': role,
      },
    );
    return status;
  }

  ///
  /// [addGroupToProject] returns a true if the given group was successfully
  /// added to the given project, and false otherwise
  ///
  /// the given project is identified by the [projectId] and the group via the
  /// [groupId]
  /// [role] represents the role the user has within that project, and basically
  /// sets permissions for certain actions. This value is optional, and if none
  /// is provided, the default is 'project-member' which is a
  /// middle-of-the-road permission level, granting higher priviledges compared
  /// to a 'project-viewer', but lower than a 'project-manager'
  ///
  Future<bool> addGroupToProject({
    @required int projectId,
    @required int groupId,
    String role = 'project-member',
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: projectPermissionCommands[ProjectPermissionProcedures.addGroup],
      params: {
        'project_id': projectId.toString(),
        'group_id': groupId.toString(),
        'role': role,
      },
    );
    return status;
  }

  ///
  /// [removeUserFromProject] returns a true if the given user was successfully
  /// removed from the given project, and false otherwise
  ///
  /// This function revokes access to user [userId] from group [groupId]
  ///
  Future<bool> removeUserFromProject({
    @required int projectId,
    @required int userId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command:
          projectPermissionCommands[ProjectPermissionProcedures.removeUser],
      params: {
        'project_id': projectId.toString(),
        'user_id': userId.toString(),
      },
    );
    return status;
  }

  ///
  /// [removeGroupFromProject] returns a true if the given group was
  /// successfully removed from the given project, and false otherwise
  ///
  /// This function revokes access to project [projectId] from group [groupId]
  ///
  Future<bool> removeGroupFromProject({
    @required int projectId,
    @required int groupId,
  }) async {
    final bool result = await KanboardAPI().getBool(
      command:
          projectPermissionCommands[ProjectPermissionProcedures.removeGroup],
      params: {
        'project_id': projectId.toString(),
        'group_id': groupId.toString(),
      },
    );
    return result;
  }

  ///
  /// [changeUserRole] returns a true if the given user was successfully
  /// updated in the given project, and false otherwise
  ///
  /// the given project is identified by the [projectId] and the user via the
  /// [userId]
  /// [role] represents the role the user has within that project, and basically
  /// sets permissions for certain actions. This value is optional, and if none
  /// is provided, the default is 'project-member' which is a
  /// middle-of-the-road permission level, granting higher priviledges compared
  /// to a 'project-viewer', but lower than a 'project-manager'
  ///
  Future<bool> changeUserRole({
    @required int projectId,
    @required int userId,
    @required String role,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command:
          projectPermissionCommands[ProjectPermissionProcedures.changeUserRole],
      params: {
        'project_id': projectId.toString(),
        'user_id': userId.toString(),
        'role': role,
      },
    );
    return status;
  }

  ///
  /// [changeGroupRole] returns a true if the given group was successfully
  /// updated in the given project, and false otherwise
  ///
  /// the given project is identified by the [projectId] and the group via the
  /// [groupId]
  /// [role] represents the role the group has within that project, and
  /// basically sets permissions for certain actions. This value is optional,
  /// and if none is provided, the default is 'project-member' which is a
  /// middle-of-the-road permission level, granting higher priviledges compared
  /// to a 'project-viewer', but lower than a 'project-manager'
  ///
  Future<bool> changeGroupRole({
    @required int projectId,
    @required int groupId,
    @required String role,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: projectPermissionCommands[
          ProjectPermissionProcedures.changeGroupRole],
      params: {
        'project_id': projectId.toString(),
        'group_id': groupId.toString(),
        'role': role,
      },
    );
    return status;
  }

  ///
  /// [getUserRole] returns the role of the user [userId] within the project
  /// [projectId]
  ///
  Future<String> getUserRole({
    @required int projectId,
    @required int userId,
  }) async {
    final String value = await KanboardAPI().getString(
      command:
          projectPermissionCommands[ProjectPermissionProcedures.getUserRole],
      params: {
        'project_id': projectId.toString(),
        'user_id': userId.toString(),
      },
    );
    return value;
  }

  ///
  /// [addToProjectMetadata] returns true if the [key]:[value] pair was
  /// successfully linked to the [projectId]
  /// If the key already exists, then the value is updated
  ///
  Future<bool> addToProjectMetadata({
    @required int projectId,
    @required String key,
    @required String value,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: projectMetadataCommands[ProjectMetadataProcedures.add],
      params: {
        'project_id': projectId.toString(),
        'values': {key: value},
      },
    );
    return status;
  }

  ///
  /// [getProjectMetadata] returns a all the metadata elements associated with
  /// the [projectId] in a {key: value} format
  ///
  Future<Map<String, String>> getProjectMetadata({
    @required int projectId,
  }) async {
    final Map<String, String> metadata =
        await KanboardAPI().getMap<String, String>(
      command: projectMetadataCommands[ProjectMetadataProcedures.getAll],
      params: {'project_id': projectId.toString()},
    );
    return metadata;
  }

  ///
  /// [getProjectMetadataByKey] returns the metadata element associated to the
  /// given [key] for the project identified by [projectId]
  /// If the given [projectId] is referencing an inexistent project or a project
  /// to which the current active user has no access, then an instance of
  /// Failure is thrown
  ///
  Future<String> getProjectMetadataByKey({
    @required int projectId,
    @required String key,
  }) async {
    final String value = await KanboardAPI().getString(
      command: projectMetadataCommands[ProjectMetadataProcedures.getByKey],
      params: {
        'project_id': projectId.toString(),
        'name': key,
      },
    );
    return value;
  }

  ///
  /// [removeFromProjectMetadata] returns true if the [key]:value pair was
  /// successfully removed from the project identified by the [projectId],
  /// or false otherwise
  ///
  Future<bool> removeFromProjectMetadata({
    @required int projectId,
    @required String key,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: projectMetadataCommands[ProjectMetadataProcedures.remove],
      params: {
        'project_id': projectId.toString(),
        'name': key,
      },
    );
    return status;
  }
}
