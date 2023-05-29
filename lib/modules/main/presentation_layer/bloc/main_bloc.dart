import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../core/services/dep_injection.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/use_cases/get_courses_use_case.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(BuildContext context) =>
      BlocProvider.of<MainBloc>(context);
  List<Course> courses = [];

  MainBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<MainEvent>((event, emit) async {
      if (event is GetCoursesEvent) {
        emit(GetCoursesLoadingState());
        var res = await GetCoursesUseCase(sl()).get();
        res.fold((l) {
          emit(GetCoursesErrorState());
        }, (r) {
          courses = r;
          print(courses);
          emit(GetCoursesSuccessState());
        });
      }
      else if (event is GetVideoSectionEvent) {
        var explode = YoutubeExplode();
        emit(GetVideoLoadingState());
        if(courses[event.courseIndex].lessons[event.lessonIndex]
            .sections[event.sectionIndex].video == null) {
          if (event.videoId != '') {
            var video = await explode.videos.get(event.videoId);
            courses[event.courseIndex].lessons[event.lessonIndex]
                .sections[event.sectionIndex].video = video;
            emit(GetVideoSuccessState());
          }
        }
      }
    });
  }
}
