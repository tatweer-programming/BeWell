part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class GetCoursesEvent extends MainEvent {}

class GetVideoSectionEvent extends MainEvent {
  final String videoId;
  final int courseIndex;
  final int lessonIndex;
  final int sectionIndex;
  GetVideoSectionEvent({
    required this.videoId,
    required this.courseIndex,
    required this.lessonIndex,
    required this.sectionIndex,
  });
}
