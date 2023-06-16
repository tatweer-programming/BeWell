import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../domain_layer/entities/course.dart';
import '../bloc/main_bloc.dart';

class LessonScreen extends StatelessWidget {
  final Course course;
  const LessonScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = sl();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsetsDirectional.all(10.sp),
            child: ListView.separated(
              itemBuilder: (context, lessonIndex) => lessonBuilder(
                lesson: course.lessons[lessonIndex],
                context: context,
                course: course,
                bloc: bloc,
                lessonIndex: lessonIndex,
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.sp,
              ),
              itemCount: course.lessons.length,
            ),
          ),
        );
      },
    );
  }
}
