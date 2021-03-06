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
    yield const LoadingState();
    try {
      if (event is CreateEvent) {
        final ProjectModel project = event.project;
        project.id = await ProjectRepository().createProject(
          name: project.name,
          description: project.description,
          ownerId: project.ownerID,
          identifier: project.identifier,
        );
        await project.init();
        yield ProjectCreatedState(project);
      } else if (event is ReadEvent) {
        switch (event.runtimeType) {
          case FetchByIdEvent:
            final ProjectModel project =
                await ProjectRepository().getProjectById(
              (event as FetchByIdEvent).projectId,
            );
            await project.init();
            yield ProjectFetchedState(project);
            break;
          case FetchByNameEvent:
            final ProjectModel project =
                await ProjectRepository().getProjectByName(
              (event as FetchByNameEvent).projectName,
            );
            await project.init();
            yield ProjectFetchedState(project);
            break;
          case FetchAllEvent:
            final List<ProjectModel> projects =
                await ProjectRepository().getAllProjects();
            for (int i = 0; i < projects.length; i++) {
              await projects[i].init();
            }
            yield ProjectListFetchedState(projects);
            break;
          case FetchFeedEvent:
            yield FeedFetchedState(
              await ProjectRepository()
                  .getFeed((event as FetchFeedEvent).projectId),
            );
            break;
          case FetchUsersEvent:
            yield UserListFetchedState(
              await ProjectRepository()
                  .getProjectUsers((event as FetchUsersEvent).projectId),
            );
            break;
          case FetchAssignableUsersEvent:
            yield UserListFetchedState(
              await ProjectRepository().getAssignableUsers(
                (event as FetchAssignableUsersEvent).projectId,
              ),
            );
            break;
          case FetchUserRoleEvent:
            yield UserRoleFetchedState(
              await ProjectRepository().getUserRole(
                projectId: (event as FetchUserRoleEvent).projectId,
                userId: (event as FetchUserRoleEvent).userId,
              ),
            );
            break;
          case FetchMetadataByKeyEvent:
            yield MetadataFetchedByKeyState(
              await ProjectRepository().getProjectMetadataByKey(
                projectId: (event as FetchMetadataByKeyEvent).projectId,
                key: (event as FetchMetadataByKeyEvent).key,
              ),
            );
            break;
          case FetchAllMetadataEvent:
            yield MetadataFetchedState(
              await ProjectRepository().getProjectMetadata(
                projectId: (event as FetchAllMetadataEvent).projectId,
              ),
            );
            break;
          default:
            yield const ErrorState('Unknown fetch event');
            break;
        }
      } else if (event is UpdateEvent) {
        switch (event.runtimeType) {
          case UpdateProjectEvent:
            final ProjectModel project = (event as UpdateProjectEvent).project;
            yield ProjectUpdatedState(
              await ProjectRepository().updateProject(
                id: project.id,
                ownerId: project.ownerID,
                name: project.name,
                description: project.description,
                identifier: project.identifier,
              ),
            );
            break;
          case DisableProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository()
                  .disableProject((event as DisableProjectEvent).projectId),
            );
            break;
          case EnableProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository()
                  .enableProject((event as EnableProjectEvent).projectId),
            );
            break;
          case DisablePublicAccessEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().disablePublicAccess(
                (event as DisablePublicAccessEvent).projectId,
              ),
            );
            break;
          case EnablePublicAccessEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().enablePublicAccess(
                (event as EnablePublicAccessEvent).projectId,
              ),
            );
            break;
          case AddUserToProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().addUserToProject(
                projectId: (event as AddUserToProjectEvent).projectId,
                userId: (event as AddUserToProjectEvent).userId,
                role: (event as ChangeUserRoleEvent).userRole,
              ),
            );
            break;
          case ChangeUserRoleEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().changeUserRole(
                projectId: (event as ChangeUserRoleEvent).projectId,
                userId: (event as ChangeUserRoleEvent).userId,
                role: (event as ChangeUserRoleEvent).userRole,
              ),
            );
            break;
          case RemoveUserFromProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().removeUserFromProject(
                projectId: (event as RemoveUserFromProjectEvent).projectId,
                userId: (event as RemoveUserFromProjectEvent).userId,
              ),
            );
            break;
          case AddGroupToProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().addGroupToProject(
                projectId: (event as AddGroupToProjectEvent).projectId,
                groupId: (event as AddGroupToProjectEvent).groupId,
                role: (event as AddGroupToProjectEvent).groupRole,
              ),
            );
            break;
          case ChangeGroupRoleEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().changeGroupRole(
                projectId: (event as ChangeGroupRoleEvent).projectId,
                groupId: (event as ChangeGroupRoleEvent).groupId,
                role: (event as ChangeGroupRoleEvent).groupRole,
              ),
            );
            break;
          case RemoveGroupFromProjectEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().removeGroupFromProject(
                projectId: (event as RemoveGroupFromProjectEvent).projectId,
                groupId: (event as RemoveGroupFromProjectEvent).groupId,
              ),
            );
            break;
          case AddMetadataEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().addToProjectMetadata(
                projectId: (event as AddMetadataEvent).projectId,
                key: (event as AddMetadataEvent).key,
                value: (event as AddMetadataEvent).value,
              ),
            );
            break;
          case RemoveMetadataEvent:
            yield ProjectUpdatedState(
              await ProjectRepository().removeFromProjectMetadata(
                projectId: (event as RemoveMetadataEvent).projectId,
                key: (event as RemoveMetadataEvent).key,
              ),
            );
            break;
          default:
            yield const ErrorState('Unknown update event');
            break;
        }
      } else if (event is DeleteEvent) {
        yield ProjectRemovedState(
          await ProjectRepository().removeProject(event.projectId),
        );
      }
    } on Failure catch (f) {
      yield ErrorState(f.message);
    }
  }
}
