import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/content_section_screen.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/lesson_screen.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/seection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/numbers_manager.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/lesson.dart';
import '../../domain_layer/entities/section.dart';
import '../bloc/main_bloc.dart';

Widget courseBuilder({
  required Course course,
  required BuildContext context,
  required int courseIndex,
  required MainBloc bloc,
}) {
  return InkWell(
    onTap: () {
      bloc.countPrefix(courseIndex);
      NavigationManager.push(context, LessonScreen(course: course,));
    },
    child: Card(
      elevation: 5.sp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.9.sp,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: ColorManager.card,
                    borderRadius: BorderRadius.circular(20.sp),
                    image: DecorationImage(
                      image: AssetImage("assets/images/image_2.png"),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 2.sp,
            ),
            Text(
              course.courseName,
              style: TextStyle(
                fontSize: FontSizeManager.s14.sp,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              "${NumbersManager.engNumberToArabic("${course.lessons.length}")} دروس ",
              style: TextStyle(
                fontSize: FontSizeManager.s12.sp,
                color: ColorManager.grey2,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget lessonBuilder({
  required Lesson lesson,
  required BuildContext context,
  required Course course,
  // required int courseIndex,
  required int lessonIndex,
  // required String courseName,
  required MainBloc bloc,
}) {
  if (bloc.prefixLesson[lessonIndex] == bloc.doneSection!.done[course.courseName]) {
    return InkWell(
      onTap: () {
        if (bloc.prefixLesson[lessonIndex] <= bloc.doneSection!.done[course.courseName]!) {
        NavigationManager.push(
            context,
            SectionScreen(lessonIndex: lessonIndex,course: course, lesson: lesson,));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    return AlertDialog(
                      content: const Text("يجب ان تنتهي من الدرس السابق اولاً",
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                        ),),
                      actions: [
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("موافق")),
                        ),
                      ],
                    );
                  });
            });
      }
      },
      child: Card(
        elevation: 5.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp)
        ),
        child: Container(
          height: MediaQuery.of(context).size.height*0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.sp),
                          topRight: Radius.circular(10.sp),
                        ),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/image_1.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Text("الدرس الحالي",
                      style: TextStyle(
                          color: ColorManager.white,
                          fontSize: FontSizeManager.s12.sp
                      ),),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.sp
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        Text(
                          lesson.lessonName,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSizeManager.s15.sp),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Text(
                          "${NumbersManager.engNumberToArabic("${lesson.sections.length}")} قسم ",
                          style: TextStyle(
                              color: ColorManager.grey2,
                              fontSize: FontSizeManager.s12.sp),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (bloc.prefixLesson[lessonIndex] > bloc.doneSection!.done[course.courseName]!)
                      const Icon(Icons.lock)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
    return InkWell(
      onTap: () {
        if (bloc.prefixLesson[lessonIndex] <= bloc.doneSection!.done[course.courseName]!) {
          NavigationManager.push(
            context,
            SectionScreen(lessonIndex: lessonIndex,course: course,lesson: lesson,));
        }else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return AlertDialog(
                        content: const Text("يجب ان تنتهي من الدرس السابق اولاً",
                          style: TextStyle(
                            fontWeight: FontWeightManager.bold,
                          ),),
                        actions: [
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("موافق")),
                          ),
                        ],
                      );
                    });
              });
        }
      },
      child: Card(
        elevation: 5.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Container(
          height: 85.sp,
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10.sp
            ),
            child: Row(
              children: [
                Container(
                  height: 65.sp,
                  width: 75.sp,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: ColorManager.card,
                      borderRadius: BorderRadius.circular(10.sp),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/image_1.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.lessonName,
                      style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSizeManager.s15.sp),
                    ),
                    Text(
                      "${NumbersManager.engNumberToArabic("${lesson.sections.length}")} قسم ",
                      style: TextStyle(
                          color: ColorManager.grey2,
                          fontSize: FontSizeManager.s12.sp),
                    ),
                  ],
                ),
                const Spacer(),
                if (bloc.prefixLesson[lessonIndex] >= bloc.doneSection!.done[course.courseName]!)
                  const Icon(Icons.lock)
                else if (course.lessons[lessonIndex].sections.length < bloc.doneSection!.done[course.courseName]!)
                  const Icon(Icons.check_circle_rounded)
              ],
            ),
          ),
        ),
      ),
    );
}

Widget sectionBuilder({
  required Section section,
  required BuildContext context,
  required MainBloc bloc,
  required Course course,
  required int lessonIndex,
  // required int courseIndex,
  // required String courseName,
  required int sectionsIndex,
}) {
  return InkWell(
    onTap: () {
    if (bloc.prefixLesson[lessonIndex] + sectionsIndex <= bloc.doneSection!.done[course.courseName]!){
        bloc.add(ToContentSectionEvent(
            whichSection: bloc.prefixLesson[lessonIndex] + sectionsIndex,
            section: section,courseName:course.courseName,context: context));
      }
    else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    return AlertDialog(
                      content: const Text("يجب ان تنتهي من القسم السابق اولاً",
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                        ),),
                      actions: [
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("موافق")),
                        ),
                      ],
                    );
                  });
            });
      }
    },
    child: Card(
      elevation: 5.sp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Container(
        height: 85.sp,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10.sp)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 10.sp
          ),
          child: Row(
            children: [
              Container(
                height: 65.sp,
                width: 75.sp,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: ColorManager.card,
                    borderRadius: BorderRadius.circular(10.sp),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/image_1.png"),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10.sp,
              ),
              Text(
                "قسم  ${NumbersManager.engNumberToArabic("${sectionsIndex+1}")}",
                style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSizeManager.s15.sp),
              ),
              const Spacer(),
              if (bloc.prefixLesson[lessonIndex] + sectionsIndex > bloc.doneSection!.done[course.courseName]!)
                const Icon(Icons.lock)
              else if (bloc.prefixLesson[lessonIndex] + sectionsIndex < bloc.doneSection!.done[course.courseName]!)
                const Icon(Icons.check_circle_rounded)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  double? width = double.infinity,
  double? height,
  Color? textColor,
  Color? buttonColor,
  Color? borderColor,
  double? fontSize,
  FontWeight? fontWeight,
}) => Container(
      decoration: BoxDecoration(
        color: buttonColor ?? ColorManager.primary,
        border: Border.all(
          color: borderColor ?? ColorManager.black.withOpacity(0),
        ),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      width: width,
      height: height ?? 40.sp,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 15.sp,
            fontWeight: fontWeight,
            color: textColor ?? ColorManager.white,
          ),
        ),
      ),
    );

Widget imageScreen({
  required double height,
  required String image,

}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        elevation: 5.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Container(
          height: height,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: ColorManager.card,
              borderRadius: BorderRadius.circular(10.sp),
              image: DecorationImage(
                image: NetworkImage(image,),
                fit: BoxFit.fill,
              )),
        ),
      ),
    ],
  );
}
Widget textScreen({
  required String text
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        elevation: 5.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Container(
          padding: EdgeInsets.all(10.sp),
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Text(text,
          style: TextStyle(
            fontSize: FontSizeManager.s18.sp,
            fontWeight: FontWeightManager.bold
          ),
          ),
        ),
      ),
    ],
  );
}