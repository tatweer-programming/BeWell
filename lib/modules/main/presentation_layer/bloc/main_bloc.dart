import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:BeWell/modules/main/domain_layer/use_cases/done_section_use_case.dart';
import 'package:BeWell/modules/main/domain_layer/use_cases/get_progress_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../core/error/remote_error.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../authenticaion/presentation_layer/components/components.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/lesson.dart';
import '../../domain_layer/use_cases/get_courses_use_case.dart';
import '../components/components.dart';
import '../screens/content_section_screen.dart';
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
    print(prefixLesson);
  }

  Future<void> contentSection({
    required Section section,
    required double height,
  })async{
    widgets = [];
    List<Video> videos = [];
    var explode = YoutubeExplode();
    if(section.videos == null || section.videos!.isEmpty){
     if(section.videosIds!.isNotEmpty && section.videosIds != null){
       for(var videoId in section.videosIds!) {
         Video video = await explode.videos.get(videoId);
         videos.add(video);
         widgets.add(PlayVideoScreen(video: video));
       }
       section.videos = videos;
     }
    }
    else if(section.videos != null){
      for(var video in section.videos!) {
        widgets.add(PlayVideoScreen(video: video));
      }
    }
    if(section.image != '' && section.image != null){
      widgets.add(imageScreen(height: height,image: section.image!));
    }if(section.text != '' && section.text != null){
      widgets.add(textScreen(text: section.text!));
    }
  }

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
        NavigationManager.push(event.context, ContentSectionScreen(
          courseName: event.courseName,whichSection: event.whichSection,));
        await contentSection(height: 200.sp,section: event.section);
        if(widgets.length == 1) doneButtonString="انتهاء";
        emit(ToContentSectionSuccessState());
      }else if (event is OnPageChangedEvent){
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
          emit(GetProgressErrorState());
        }, (r) {
          doneSection = r;
          emit(GetProgressSuccessState());
        });
      }
    });
  }
}
