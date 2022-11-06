import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';
import '../../../data/repository/project_repository.dart';
import '../../../data/singletons/kanboard_api_client.dart';
import './events/events.dart';
import './states/states.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial());

  @override
  Stream<ProjectsState> mapEventToState(
    ProjectsEvent event,
  ) async* {
    yield const ProjectLoading();
    try {
      if (event is CreateProject) {
        final ProjectModel project = event.project;
        project.id = await ProjectRepository().createProject(
          name: project.name,
          description: project.description,
          ownerId: project.ownerID,
          identifier: project.identifier,
        );
        await project.init();
        yield ProjectCreated(project);
        return;
      }

      if (event is ReadProjectEvent) {
        if (event is FetchSingleProject) {
          ProjectModel project;

          if (event is FetchProjectById) {
            project = await ProjectRepository().getProjectById(event.id);
          } else if (event is FethchProjectByName) {
            project = await ProjectRepository().getProjectByName(event.name);
          }

          await project.init();
          yield ProjectFetched(project);
          return;
        }

        if (event is FetchProjectList) {
          List<ProjectModel> projects;

          if (event is FetchAllProjects) {
            projects = await ProjectRepository().getAllProjects();
          } else if (event is FetchPublicProjects) {
            projects = (await ProjectRepository().getAllProjects())
                .where((element) => element.isPrivate == false)
                .toList();
          } else if (event is FetchPersonalProjects) {
            projects = (await ProjectRepository().getAllProjects())
                .where((element) => element.isPrivate == true)
                .toList();
          } else if (event is FetchStarredProjects) {
            projects = (await ProjectRepository().getAllProjects())
                .where((element) => element.isStarred == true)
                .toList();
          }

          for (int i = 0; i < projects.length; i++) {
            await projects[i].init();
          }
          yield ProjectListFetched(projects);
          return;
        }

        if (event is FetchFeedForProject) {
          final List<EventModel> feed =
              await ProjectRepository().getFeed(event.id);
          yield FeedFetched(feed);
          return;
        }

        if (event is FetchUserList) {
          List<UserModel> users;

          if (event is FetchAssignableUsers) {
            users = await ProjectRepository().getAssignableUsers(event.id);
          } else if (event is FetchProjectUsers) {
            users = await ProjectRepository().getProjectUsers(event.id);
          }

          yield UserListFetched(users);
          return;
        }

        if (event is FetchUserRole) {
          final String role = await ProjectRepository().getUserRole(
            projectId: event.id,
            userId: event.userId,
          );
          yield UserRoleFetched(role);
          return;
        }

        if (event is FetchMetadataByKey) {
          final String value = await ProjectRepository()
              .getProjectMetadataByKey(projectId: event.id, key: event.key);
          yield MetadataFetchedByKey(value);
          return;
        }
        if (event is FetchAllMetadata) {
          final Map<String, String> metadata =
              await ProjectRepository().getProjectMetadata(projectId: event.id);
          yield MetadataFetched(metadata);
          return;
        }
      }

      if (event is UpdateProjectEvent) {
        bool status = false;
        if (event is UpdateProject) {
          status = await ProjectRepository().updateProject(
            id: event.project.id,
            ownerId: event.project.ownerID,
            name: event.project.name,
            description: event.project.description,
            identifier: event.project.identifier,
          );
        } else if (event is DisableProject) {
          status = await ProjectRepository().disableProject(event.id);
        } else if (event is EnableProject) {
          status = await ProjectRepository().enableProject(event.id);
        } else if (event is DisablePublicAccess) {
          status = await ProjectRepository().disablePublicAccess(event.id);
        } else if (event is EnablePublicAccess) {
          status = await ProjectRepository().enablePublicAccess(event.id);
        } else if (event is AddUserToProject) {
          status = await ProjectRepository().addUserToProject(
            projectId: event.projectId,
            userId: event.userId,
            role: event.userRole,
          );
        } else if (event is AddGroupToProject) {
          status = await ProjectRepository().addGroupToProject(
            projectId: event.projectId,
            groupId: event.groupId,
            role: event.groupRole,
          );
        } else if (event is ChangeUserRole) {
          status = await ProjectRepository().changeUserRole(
            projectId: event.projectId,
            userId: event.userId,
            role: event.userRole,
          );
        } else if (event is ChangeGroupRole) {
          status = await ProjectRepository().changeGroupRole(
            projectId: event.projectId,
            groupId: event.groupId,
            role: event.groupRole,
          );
        } else if (event is RemoveUserFromProject) {
          status = await ProjectRepository().removeUserFromProject(
            projectId: event.projectId,
            userId: event.userId,
          );
        } else if (event is RemoveGroupFromProject) {
          status = await ProjectRepository().removeGroupFromProject(
            projectId: event.projectId,
            groupId: event.groupId,
          );
        } else if (event is AddMetadata) {
          status = await ProjectRepository().addToProjectMetadata(
            projectId: event.projectId,
            key: event.key,
            value: event.value,
          );
        } else if (event is RemoveMetadata) {
          status = await ProjectRepository().removeFromProjectMetadata(
            projectId: event.projectId,
            key: event.key,
          );
        }
        yield ProjectUpdated(status);
        return;
      }

      if (event is DeleteProjectEvent) {
        yield ProjectRemoved(
          await ProjectRepository().removeProject(event.id),
        );
      }
    } on Failure catch (f) {
      yield ProjectError(f.message);
    }
  }
}
