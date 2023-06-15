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
  const SectionScreen({Key? key, required this.lesson, required this.lessonIndex,required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = MainBloc.get(context);
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 10.sp,
              start: 10.sp,
              end: 10.sp,
              top: 20.sp
            ),
            child: ListView.separated(
              itemBuilder: (context, sectionIndex) => sectionBuilder(
                section: lesson.sections[sectionIndex],
                context: context,
                bloc:bloc,
                course: course,
                lessonIndex:lessonIndex,
                sectionsIndex:sectionIndex,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10.sp,),
              itemCount: lesson.sections.length,
            ),
          ),
        );
      },
    );
  }
}
