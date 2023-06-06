import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/main_bloc.dart';

class LessonScreen extends StatelessWidget {
  final int courseIndex;
  final String courseName;
  const LessonScreen({Key? key, required this.courseIndex, required this.courseName}) : super(key: key);

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
                itemBuilder: (context, lessonIndex) => lessonBuilder(
                  lesson: bloc.courses[courseIndex]
                      .lessons[lessonIndex],
                  context: context,
                  courseIndex: courseIndex,
                  bloc: bloc,
                  sectionsLength: bloc.courses[courseIndex]
                      .lessons[lessonIndex].sections.length,
                  lessonIndex: lessonIndex,
                  courseName: courseName,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.sp,),
                itemCount: bloc.courses[courseIndex]
                    .lessons.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
