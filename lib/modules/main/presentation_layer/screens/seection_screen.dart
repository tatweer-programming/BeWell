import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/main_bloc.dart';


class SectionScreen extends StatelessWidget {
  final int lessonIndex;
  final int courseIndex;
  final String courseName;
  const SectionScreen({Key? key, required this.lessonIndex,required this.courseIndex,required this.courseName}) : super(key: key);

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
                  section: bloc.courses[courseIndex].lessons[lessonIndex].sections[sectionIndex],
                  context: context,
                  bloc:bloc,
                  lessonIndex:lessonIndex,
                  courseName:courseName,
                  courseIndex:courseIndex,
                  sectionsIndex:sectionIndex,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.sp,),
                itemCount: bloc.courses[courseIndex]
                    .lessons[lessonIndex].sections.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
