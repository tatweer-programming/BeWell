part of 'main_bloc.dart';

abstract class MainState {}

class MainInitial extends MainState {}
// GetCourses
class GetCoursesLoadingState extends MainState {}
class GetCoursesSuccessState extends MainState {}
class GetCoursesErrorState extends MainState {}
// GetVideo
class GetVideoLoadingState extends MainState {}
class GetVideoSuccessState extends MainState {}
class GetVideoErrorState extends MainState {}