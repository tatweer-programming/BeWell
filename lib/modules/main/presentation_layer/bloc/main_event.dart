part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class GetCoursesEvent extends MainEvent {}
class GetProgressEvent extends MainEvent {}
class OnPageChangedEvent extends MainEvent {
  final int index;
  OnPageChangedEvent({required this.index});
}
class DoneSectionEvent extends MainEvent {
  final String courseName;
  final double progress;
  final int done;
  DoneSectionEvent({
    required this.courseName,
    required this.progress,
    required this.done,
  });
}
class LogOutEvent extends MainEvent {
  final BuildContext context;
  const LogOutEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
class ToContentSectionEvent extends MainEvent {
  final BuildContext context;
  final Section section;
  final String courseName;
  final int whichSection;
  ToContentSectionEvent({
    required this.section,
    required this.courseName,
    required this.whichSection,
    required this.context,
});
}
class ShowQuizAnswerEvent extends MainEvent {

}