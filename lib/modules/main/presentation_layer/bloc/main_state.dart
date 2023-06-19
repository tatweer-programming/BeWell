part of 'main_bloc.dart';

abstract class MainState {}

class MainInitial extends MainState {}

// GetCourses
class GetCoursesLoadingState extends MainState {}

class GetCoursesSuccessState extends MainState {}

class GetCoursesErrorState extends MainState {}
// GetDailyReminder
class GetDailyReminderLoadingState extends MainState {}

class GetDailyReminderSuccessState extends MainState {}

class GetDailyReminderErrorState extends MainState {}

// ToContentSection
class ToContentSectionLoadingState extends MainState {}

class ToContentSectionSuccessState extends MainState {}

// DoneSection
class DoneSectionLoadingState extends MainState {}

class DoneSectionSuccessState extends MainState {}

class DoneSectionErrorState extends MainState {}

// GetProgress
class GetProgressLoadingState extends MainState {}

class GetProgressSuccessState extends MainState {}

class GetProgressErrorState extends MainState {}

class OnPageChangedState extends MainState {
  final String doneButtonString;
  OnPageChangedState(this.doneButtonString);
}

class ShowQuizAnswerState extends MainState {}

class LogOutSuccessfulAuthState extends MainState {
  final BuildContext context;
  LogOutSuccessfulAuthState({required this.context});
}
