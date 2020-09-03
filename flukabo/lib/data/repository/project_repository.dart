import 'dart:convert';

import 'package:flukabo/data/models/event.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/repository/user_repository.dart';
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
  /// [createProject] returns true if the Project was succesfully created or
  /// false otherwise.
  ///
  /// [name] is required as all Projects must have a name
  /// [description], [ownerId] and [identifier] are optional parameters.
  /// If no values are provided, [description] will be empty, the [ownerId] will
  /// be '0' and the [identifier] will also be empty
  ///
  /// the [id] of the newly created Project is the [statusCode] (as long as it
  /// is not 0. then if means there was an error)
  ///
  Future<bool> createProject({
    @required String name,
    String description = '',
    int ownerId = 0,
    String identifier = '',
  }) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.create],
      params: {
        'name': name,
        'description': description,
        'owner_id': ownerId.toString(),
        'identifier': identifier,
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    final int statusCode = response == 'false' ? 0 : int.parse(response);
    if (response == 'false') {
      print('Failed to create Project');
      return false;
    } else {
      print('Project created succesfully. ProjID: $statusCode');
      return true;
    }
  }

  ///
  ///[getProjectById] returns a Project object if the given id is valid
  /// or throws a Failure otherwise
  ///
  Future<ProjectModel> getProjectById(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.getById],
      params: {'project_id': id.toString()},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      print('Successfully fetched project $id.');
      return ProjectModel.fromJson(result);
    } else {
      throw const Failure('Failed to fetch project.');
    }
  }

  ///
  ///[getProjectByName] returns a Project object if the given name is valid
  /// or throws a Failure otherwise (also throws failure if name doesn't exist)
  ///
  Future<ProjectModel> getProjectByName(String name) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.getByName],
      params: {'name': name},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      print('Successfully fetched project $name.');
      return ProjectModel.fromJson(result);
    } else {
      print('Failed to fetch user.');
      throw const Failure('Failed to fetch user.');
    }
  }

  ///
  /// [getAllProjects] returns a List of projects if the fetch was successfull,
  /// or it throws a Failure if the api call failed for some reason
  ///
  Future<List<ProjectModel>> getAllProjects() async {
    final List<ProjectModel> projects = [];
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.getAll],
      params: {},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        projects.add(
            ProjectModel.fromJson(Map.from(result[i] as Map<String, dynamic>)));
      }
      print('Succesfully fetched ${projects.length} projects.');
      return projects;
    } else {
      print('Failed to fetch projects.');
      throw const Failure('Failed to fetch projects.');
    }
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
    ProjectModel project;
    try {
      project = await getProjectById(id);
    } on Failure catch (f) {
      print(f.message);
      rethrow;
    }
    final String json = await KanboardAPI().getJson(
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
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully updated project $id.');
      return result == 'true';
    } else {
      print('Failed to fetch project.');
      return false;
    }
  }

  ///
  /// [removeProject] returns true if the project was successfully removed, or
  /// false otherwise
  /// This function completely removes the project from the databse.
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeProject(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.remove],
      params: {
        'project_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully removed project $id.');
      return result == 'true';
    } else {
      print('Failed to remove project.');
      return false;
    }
  }

  ///
  /// [disableProject] returns true if the project was successfully disabled,
  /// or false otherwise
  /// This function sets the project.isActive to false
  /// This can be undone via the [enableProject] function
  ///
  Future<bool> disableProject(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.disable],
      params: {
        'project_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully disabled project $id.');
      return result == 'true';
    } else {
      print('Failed to disable project.');
      return false;
    }
  }

  ///
  /// [enableProject] returns true if the project was successfully enabled, or
  /// false otherwise
  /// This function sets the project.isActive to true
  /// This can be undone via the [disableProject] function
  ///
  Future<bool> enableProject(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.enable],
      params: {
        'project_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully enabled project $id.');
      return result == 'true';
    } else {
      print('Failed to enable project.');
      return false;
    }
  }

  ///
  /// [disablePublicAccess] returns true if the project accessibility level
  /// was successfully changed to non-public
  /// otherwise
  /// This function sets the project.isPublic to false
  /// This can be undone via the [enablePublicAccess] function
  ///
  Future<bool> disablePublicAccess(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.disablePublicAccess],
      params: {
        'project_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully disabled public access for project $id.');
      return result == 'true';
    } else {
      print('Failed to disable public access.');
      return false;
    }
  }

  ///
  /// [enablePublicAccess] returns true if the project accessibility level
  /// was successfully changed to public
  /// This function sets the project.isPublic to true
  /// This can be undone via the [disablePublicAccess] function
  ///
  Future<bool> enablePublicAccess(int id) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.enablePublicAccess],
      params: {
        'project_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully enabled public access for project $id.');
      return result == 'true';
    } else {
      print('Failed to enable public access.');
      return false;
    }
  }

  ///
  /// [getAllProjects] returns a List of projects if the fetch was successfull,
  /// or it throws a Failure if the api call failed for some reason
  ///
  Future<List<EventModel>> getFeed(int id) async {
    final List<EventModel> events = [];
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.getActivity],
      params: {'project_id': id.toString()},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        events.add(
            EventModel.fromJson(Map.from(result[i] as Map<String, dynamic>)));
      }
      print('Succesfully fetched ${events.length} events.');
      return events;
    } else {
      print('Failed to fetch events.');
      throw const Failure('Failed to fetch events.');
    }
  }

  ///
  /// [getProjectUsers] returns a List of all users associated with the given
  /// project (by [id]) or throws a Failure if the api call failed for some
  /// reason
  ///
  Future<List<UserModel>> getProjectUsers(int id) async {
    final List<UserModel> users = [];
    final String json = await KanboardAPI().getJson(
      command: projectPermissionCommands[ProjectPermissionProcedures.getUsers],
      params: {'project_id': id.toString()},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      final List<String> ids = result.keys.toList();
      for (int i = 0; i < ids.length; i++) {
        users.add(await UserRepository().getUserById(int.parse(ids[i])));
      }
      print('Succesfully fetched ${users.length} users.');
      return users;
    } else {
      print('Failed to fetch users.');
      throw const Failure('Failed to fetch users.');
    }
  }

  ///
  /// [getProjectUsers] returns a List of all users associated with the given
  /// project (by [id]) with a role higher than 'project-viewer' or throws a
  /// Failure if the api call failed for some reason
  ///
  Future<List<UserModel>> getAssignableUsers(int id) async {
    final List<UserModel> users = [];
    final String json = await KanboardAPI().getJson(
      command: projectPermissionCommands[
          ProjectPermissionProcedures.getAssignableUsers],
      params: {'project_id': id.toString()},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      final List<String> ids = result.keys.toList();
      for (int i = 0; i < ids.length; i++) {
        users.add(await UserRepository().getUserById(int.parse(ids[i])));
      }
      print('Succesfully fetched ${users.length} users.');
      return users;
    } else {
      print('Failed to fetch users.');
      throw const Failure('Failed to fetch users.');
    }
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
    final String json = await KanboardAPI().getJson(
      command: projectPermissionCommands[ProjectPermissionProcedures.addUser],
      params: {
        'project_id': projectId.toString(),
        'user_id': userId.toString(),
        'role': role,
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false') {
      print(
          'Successfully added user $userId to project $projectId with the role of $role');
      return result == 'true';
    } else {
      print('Failed to add user to project.');
      return false;
    }
  }
}
