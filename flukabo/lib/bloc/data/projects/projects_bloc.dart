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
      } else if (event is ReadProjectEvent) {
        switch (event.runtimeType) {
          case FetchProjectById:
            final ProjectModel project =
                await ProjectRepository().getProjectById(
              (event as FetchProjectById).projectId,
            );
            await project.init();
            yield ProjectFetched(project);
            break;
          case FethchProjectByName:
            final ProjectModel project =
                await ProjectRepository().getProjectByName(
              (event as FethchProjectByName).projectName,
            );
            await project.init();
            yield ProjectFetched(project);
            break;
          case FetchAllProjects:
            final List<ProjectModel> projects =
                await ProjectRepository().getAllProjects();
            for (int i = 0; i < projects.length; i++) {
              await projects[i].init();
            }
            yield ProjectListFetched(projects);
            break;
          case FetchFeedForProject:
            yield FeedFetched(
              await ProjectRepository()
                  .getFeed((event as FetchFeedForProject).projectId),
            );
            break;
          case FetchProjectUsers:
            yield UserListFetched(
              await ProjectRepository()
                  .getProjectUsers((event as FetchProjectUsers).projectId),
            );
            break;
          case FetchAssignableUsers:
            yield UserListFetched(
              await ProjectRepository().getAssignableUsers(
                (event as FetchAssignableUsers).projectId,
              ),
            );
            break;
          case FetchUserRole:
            yield UserRoleFetched(
              await ProjectRepository().getUserRole(
                projectId: (event as FetchUserRole).projectId,
                userId: (event as FetchUserRole).userId,
              ),
            );
            break;
          case FetchMetadataByKey:
            yield MetadataFetchedByKey(
              await ProjectRepository().getProjectMetadataByKey(
                projectId: (event as FetchMetadataByKey).projectId,
                key: (event as FetchMetadataByKey).key,
              ),
            );
            break;
          case FetchAllMetadata:
            yield MetadataFetched(
              await ProjectRepository().getProjectMetadata(
                projectId: (event as FetchAllMetadata).projectId,
              ),
            );
            break;
          default:
            yield const ProjectError('Unknown fetch event');
            break;
        }
      } else if (event is UpdateProjectEvent) {
        switch (event.runtimeType) {
          case UpdateProject:
            final ProjectModel project = (event as UpdateProject).project;
            yield ProjectUpdated(
              await ProjectRepository().updateProject(
                id: project.id,
                ownerId: project.ownerID,
                name: project.name,
                description: project.description,
                identifier: project.identifier,
              ),
            );
            break;
          case DisableProject:
            yield ProjectUpdated(
              await ProjectRepository()
                  .disableProject((event as DisableProject).projectId),
            );
            break;
          case EnableProject:
            yield ProjectUpdated(
              await ProjectRepository()
                  .enableProject((event as EnableProject).projectId),
            );
            break;
          case DisablePublicAccess:
            yield ProjectUpdated(
              await ProjectRepository().disablePublicAccess(
                (event as DisablePublicAccess).projectId,
              ),
            );
            break;
          case EnablePublicAccess:
            yield ProjectUpdated(
              await ProjectRepository().enablePublicAccess(
                (event as EnablePublicAccess).projectId,
              ),
            );
            break;
          case AddUserToProject:
            yield ProjectUpdated(
              await ProjectRepository().addUserToProject(
                projectId: (event as AddUserToProject).projectId,
                userId: (event as AddUserToProject).userId,
                role: (event as ChangeUserRole).userRole,
              ),
            );
            break;
          case ChangeUserRole:
            yield ProjectUpdated(
              await ProjectRepository().changeUserRole(
                projectId: (event as ChangeUserRole).projectId,
                userId: (event as ChangeUserRole).userId,
                role: (event as ChangeUserRole).userRole,
              ),
            );
            break;
          case RemoveUserFromProject:
            yield ProjectUpdated(
              await ProjectRepository().removeUserFromProject(
                projectId: (event as RemoveUserFromProject).projectId,
                userId: (event as RemoveUserFromProject).userId,
              ),
            );
            break;
          case AddGroupToProject:
            yield ProjectUpdated(
              await ProjectRepository().addGroupToProject(
                projectId: (event as AddGroupToProject).projectId,
                groupId: (event as AddGroupToProject).groupId,
                role: (event as AddGroupToProject).groupRole,
              ),
            );
            break;
          case ChangeGroupRole:
            yield ProjectUpdated(
              await ProjectRepository().changeGroupRole(
                projectId: (event as ChangeGroupRole).projectId,
                groupId: (event as ChangeGroupRole).groupId,
                role: (event as ChangeGroupRole).groupRole,
              ),
            );
            break;
          case RemoveGroupFromProject:
            yield ProjectUpdated(
              await ProjectRepository().removeGroupFromProject(
                projectId: (event as RemoveGroupFromProject).projectId,
                groupId: (event as RemoveGroupFromProject).groupId,
              ),
            );
            break;
          case AddMetadata:
            yield ProjectUpdated(
              await ProjectRepository().addToProjectMetadata(
                projectId: (event as AddMetadata).projectId,
                key: (event as AddMetadata).key,
                value: (event as AddMetadata).value,
              ),
            );
            break;
          case RemoveMetadata:
            yield ProjectUpdated(
              await ProjectRepository().removeFromProjectMetadata(
                projectId: (event as RemoveMetadata).projectId,
                key: (event as RemoveMetadata).key,
              ),
            );
            break;
          default:
            yield const ProjectError('Unknown update event');
            break;
        }
      } else if (event is DeleteProjectEvent) {
        yield ProjectRemoved(
          await ProjectRepository().removeProject(event.projectId),
        );
      }
    } on Failure catch (f) {
      yield ProjectError(f.message);
    }
  }
}
