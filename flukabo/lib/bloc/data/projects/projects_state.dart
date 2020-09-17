part of 'projects_bloc.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();
  
  @override
  List<Object> get props => [];
}

class ProjectsInitial extends ProjectsState {}
