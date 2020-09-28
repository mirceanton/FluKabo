import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flukabo/data/models/task.dart';
import 'package:flukabo/data/repository/task_repository.dart';
import '../../../data/singletons/kanboard_api_client.dart';
import './events/events.dart';
import './states/states.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial());

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    yield const LoadingState();
    try {
      if (event is CreateEvent) {
        final TaskModel task = event.task;
        task.id = await TaskRepository().createTask(
          title: task.title,
          projectId: task.projectId,
          colorId: task.colorId,
          columnId: task.columnId,
          ownerId: task.ownerId,
          creatorId: task.creatorId,
          dateDue: task.dateDue,
          description: task.description,
          categoryId: task.categoryId,
          complexity: task.complexity,
          swimlaneId: task.swimlaneId,
          priority: task.priority,
          recurrenceStatus: task.recurrenceStatus,
          recurrenceTrigger: task.recurrenceTrigger,
          recurrenceFactor: task.recurrenceFactor,
          recurrenceTimeframe: task.recurrenceTimeframe,
          recurrenceBasedate: task.recurrenceBasedate,
          reference: task.reference,
          tags: task.tagNames,
          dateStarted: task.dateStarted,
        );
        await task.init();
        yield TaskCreatedState(task);
      } else if (event is ReadEvent) {
        if (event is ReadObjectEvent) {
          TaskModel task;

          if (event is FetchByIdEvent) {
            task = await TaskRepository().getTaskById(event.taskId);
          } else if (event is FetchByReferenceEvent) {
            task = await TaskRepository().getTaskByReference(
              projectId: event.projectId,
              reference: event.reference,
            );
          }

          await task.init();
          yield TaskFetchedState(task);
        } else if (event is ReadObjectListEvent) {
          List<TaskModel> tasks = [];

          if (event is FetchAllForProjectEvent) {
            tasks = await TaskRepository().getAllTasks(
              projectId: event.projectId,
              isActive: event.isActive,
            );
          } else if (event is FetchAllOverdueEvent) {
            tasks = await TaskRepository().getAllOverdueTasks();
          } else if (event is FetchOverdueForProjectEvent) {
            tasks = await TaskRepository().getOverdueTasksByProject(
              event.projectId,
            );
          } else if (event is SearchEvent) {
            tasks = await TaskRepository().searchTasks(
              projectId: event.projectId,
              query: event.query,
            );
          }

          for (int i = 0; i < tasks.length; i++) {
            await tasks[i].init();
          }
          yield TaskListFetchedState(tasks);
        }
      } else if (event is UpdateEvent) {
        if (event is UpdateTaskEvent) {
          yield TaskUpdatedState(
            await TaskRepository().updateTask(
              taskId: event.task.id,
              title: event.task.title,
              colorId: event.task.colorId,
              ownerId: event.task.ownerId,
              dateDue: event.task.dateDue,
              description: event.task.description,
              categoryId: event.task.categoryId,
              complexity: event.task.complexity,
              priority: event.task.priority,
              recurrenceStatus: event.task.recurrenceStatus,
              recurrenceTrigger: event.task.recurrenceTrigger,
              recurrenceFactor: event.task.recurrenceFactor,
              recurrenceTimeframe: event.task.recurrenceTimeframe,
              recurrenceBasedate: event.task.recurrenceBasedate,
              reference: event.task.reference,
              tags: event.task.tagNames,
              dateStarted: event.task.dateStarted,
            ),
          );
        } else if (event is OpenTaskEvent) {
          yield TaskUpdatedState(await TaskRepository().openTask(event.taskId));
        } else if (event is CloseTaskEvent) {
          yield TaskUpdatedState(
            await TaskRepository().closeTask(event.taskId),
          );
        } else if (event is MoveTaskWithinProjectEvent) {
          yield TaskUpdatedState(
            await TaskRepository().moveTaskToPosition(
              projectId: event.projectId,
              taskId: event.taskId,
              columnId: event.columnId,
              position: event.position,
              swimlaneId: event.swimlaneId,
            ),
          );
        } else if (event is MoveTaskToProjectEvent) {
          yield TaskUpdatedState(
            await TaskRepository().moveTaskToProject(
              taskId: event.taskId,
              projectId: event.projectId,
              swimlaneId: event.swimlaneId,
              columnId: event.columnId,
              categoryId: event.categoryId,
              ownerId: event.ownerId,
            ),
          );
        } else if (event is CloneTaskToProjectEvent) {
          yield TaskUpdatedState(
            await TaskRepository().cloneTaskToProject(
              taskId: event.taskId,
              projectId: event.projectId,
              swimlaneId: event.swimlaneId,
              columnId: event.columnId,
              categoryId: event.categoryId,
              ownerId: event.ownerId,
            ),
          );
        }
      } else if (event is DeleteEvent) {
        yield TaskDeletedState(await TaskRepository().removeTask(event.taskId));
      }
    } on Failure catch (f) {
      yield ErrorState(f.message);
    }
  }
}
