import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/lesson.dart';
import '../bloc/main_bloc.dart';


class SectionScreen extends StatelessWidget {
  final Lesson lesson;
  final Course course;
  final int lessonIndex;
  // final int courseIndex;
  // final String courseName;
  const SectionScreen({Key? key, required this.lesson, required this.lessonIndex,required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = MainBloc.get(context);
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(10.sp),
              child: ListView.separated(
                itemBuilder: (context, sectionIndex) => sectionBuilder(
                  section: lesson.sections[sectionIndex],
                  context: context,
                  bloc:bloc,
                  course: course,
                  lessonIndex:lessonIndex,
                  // courseName:courseName,
                  // courseIndex:courseIndex,
                  sectionsIndex:sectionIndex,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.sp,),
                itemCount: lesson.sections.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
