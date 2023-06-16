import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:BeWell/modules/main/domain_layer/use_cases/done_section_use_case.dart';
import 'package:BeWell/modules/main/domain_layer/use_cases/get_progress_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/remote_error.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../authenticaion/presentation_layer/components/components.dart';
import '../../../authenticaion/presentation_layer/screens/login.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/use_cases/get_courses_use_case.dart';
import '../components/components.dart';
import '../screens/section_content_screen.dart';
import '../screens/play_video_screen.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(BuildContext context) =>
      BlocProvider.of<MainBloc>(context);
  List<Course> courses = [];
  List<Widget> widgets = [];
  List<int> prefixLesson = [];
  String doneButtonString = "التالي";
  DoneSection? doneSection;

  void countPrefix(int courseIndex){
    prefixLesson = [0];
    for(int i = 1; i <= courses[courseIndex].lessons.length;i++){
      prefixLesson.add(courses[courseIndex].lessons[i-1].sections.length + prefixLesson[i-1]);
    }
  }

/// TODO : Read this Function
  Future<void> sectionContent({
    required Section section,
  }) async{
    widgets = [];
    if(section.videosIds!.isNotEmpty && section.videosIds != null){
      for(var videoId in section.videosIds!) {
        widgets.add(PlayVideoScreen(videoId: videoId));
      }
    }
    if(section.image != '' && section.image != null){
      widgets.add(imageScreen(image: section.image!));
    }if(section.text != '' && section.text != null){
      widgets.add(textScreen(text: section.text!));
    }if(section.quiz != null && section.quiz!.questions.isNotEmpty){
      widgets.add(questionScreen(questions: section.quiz!.questions,));
    }if(section.survey != null && section.survey!.questions.isNotEmpty){
      widgets.add(SurveyScreen(survey: section.survey!,));
    }
  }
  bool showAnswer = false ;
  MainBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<MainEvent>((event, emit) async {
      if (event is GetCoursesEvent) {
        emit(GetCoursesLoadingState());
        var res = await GetCoursesUseCase(sl()).get();
        res.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(GetCoursesErrorState());
        }, (r) {
          courses = r;
          emit(GetCoursesSuccessState());
        });
      }else if (event is ToContentSectionEvent){
        emit(ToContentSectionLoadingState());
        NavigationManager.push(event.context, SectionContentScreen(
          courseName: event.courseName,whichSection: event.whichSection,));
        await sectionContent(section: event.section);
        if(widgets.length == 1) doneButtonString="انتهاء";
        emit(ToContentSectionSuccessState());
      }
      else if (event is OnPageChangedEvent){
        if(event.index == widgets.length-1) {
          doneButtonString= "انتهاء";
        }else{
          doneButtonString = "التالي";
        }
        emit(OnPageChangedState(doneButtonString));
      }
      else if (event is DoneSectionEvent){
        emit(DoneSectionLoadingState());
        var result = await DoneSectionUseCase(sl()).done(courseName: event.courseName,done:event.done,progress: event.progress);
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(DoneSectionErrorState());
        }, (r) {
          emit(DoneSectionSuccessState());
        });
      }
      else if (event is GetProgressEvent){
        emit(GetProgressLoadingState());
        var result = await GetProgressUseCase(sl()).get();
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(GetProgressErrorState());
        }, (r) {
          doneSection = r;
          ConstantsManager.doneSection = r;
          emit(GetProgressSuccessState());
        });
      }
      else if (event is ShowQuizAnswerEvent){
        showAnswer = true;
        emit(ShowQuizAnswerState());
      }
      else if (event is LogOutEvent){
        CacheHelper.removeData(key: "uid").then((value) {
          if(value){
            NavigationManager.pushAndRemove(event.context, const LoginScreen());
          }
        });
        emit(LogOutSuccessfulAuthState(context: event.context));
      }
    });
  }
}
