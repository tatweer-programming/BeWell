import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:BeWell/modules/main/presentation_layer/components/test.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/lessons_screen.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/seections_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
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
      NavigationManager.push(
          context,
          LessonScreen(
            course: course,
          ));
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
                    image: const DecorationImage(
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
  required int lessonIndex,
  required MainBloc bloc,
}) {
  int counter = 0;
  if (bloc.doneSection != null) {
    counter = bloc.doneSection!.done[course.courseName]!;
  }
  if (bloc.prefixLesson[lessonIndex] == counter) {
    return InkWell(
      onTap: () {
        if (bloc.prefixLesson[lessonIndex] <= counter) {
          NavigationManager.push(
              context,
              SectionScreen(
                lessonIndex: lessonIndex,
                course: course,
                lesson: lesson,
              ));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                  return AlertDialog(
                    content: const Text(
                      "يجب ان تنتهي من الدرس السابق اولاً",
                      style: TextStyle(
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
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
                    height: MediaQuery.of(context).size.height * 0.15,
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
                    child: Text(
                      "الدرس الحالي",
                      style: TextStyle(
                          color: ColorManager.white,
                          fontSize: FontSizeManager.s12.sp),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        Text(
                          "درس  ${NumbersManager.engNumberToArabic("${lessonIndex + 1}")}",
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
                    if (bloc.prefixLesson[lessonIndex] > counter)
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
      if (bloc.prefixLesson[lessonIndex] <= counter) {
        NavigationManager.push(
            context,
            SectionScreen(
              lessonIndex: lessonIndex,
              course: course,
              lesson: lesson,
            ));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                return AlertDialog(
                  content: const Text(
                    "يجب ان تنتهي من الدرس السابق اولاً",
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
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
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
                    "درس  ${NumbersManager.engNumberToArabic("${lessonIndex + 1}")}",
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
              if (bloc.prefixLesson[lessonIndex] > counter)
                const Icon(Icons.lock)
              else if (course.lessons[lessonIndex].sections.length <= counter)
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
  required int sectionsIndex,
}) {
  int counter = 0;
  if (bloc.doneSection != null) {
    counter = bloc.doneSection!.done[course.courseName]!;
  }
  return InkWell(
    onTap: () {
      if (bloc.prefixLesson[lessonIndex] + sectionsIndex <= counter) {
        bloc.add(ToContentSectionEvent(
            whichSection: bloc.prefixLesson[lessonIndex] + sectionsIndex,
            section: section,
            courseName: course.courseName,
            context: context));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                return AlertDialog(
                  content: const Text(
                    "يجب ان تنتهي من القسم السابق اولاً",
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
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
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
                "قسم  ${NumbersManager.engNumberToArabic("${sectionsIndex + 1}")}",
                style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSizeManager.s15.sp),
              ),
              const Spacer(),
              if (bloc.prefixLesson[lessonIndex] + sectionsIndex > counter)
                const Icon(Icons.lock)
              else if (bloc.prefixLesson[lessonIndex] + sectionsIndex < counter)
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
}) =>
    Container(
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
  required String image,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        elevation: 5.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Container(
          height: 30.h,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: ColorManager.card,
              borderRadius: BorderRadius.circular(10.sp),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.fill,
              )),
        ),
      ),
    ],
  );
}

Widget textScreen({required String text}) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 5.sp,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Container(
              padding: EdgeInsets.all(10.sp),
              width: double.infinity,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: FontSizeManager.s17.sp,
                    fontWeight: FontWeightManager.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget questionBuilder(
    {required Question question,
    required bool showAnswer,
    required BuildContext context,
    required int index}) {
  return Column(
    children: [
      Text('$index - ${question.question}',
          style:
              const TextStyle(fontWeight: FontWeightManager.bold, fontSize: 19),
          maxLines: 3),
      SizedBox(
        height: 5.sp,
      ),
    ],
  );
}

Widget answerBuilder(
    {required List<int> trueAnswer,
    String? explanation,
    required bool isCorrect}) {
  List<int> _trueAnswerText() {
    List<int> trueAnswerText = [];
    trueAnswer.forEach((element) {
      trueAnswerText.add(element + 1);
    });
    return trueAnswerText;
  }

  return Container(
    padding: EdgeInsets.all(10.sp),
    decoration: BoxDecoration(
      color: ColorManager.primary.withOpacity(.5),
      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.sp)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: ColorManager.primary,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Text(
                  isCorrect ? 'إجابة صحيحة' : 'الإجابة الصحيحة :',
                  style: const TextStyle(
                    fontWeight: FontWeightManager.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            if (!isCorrect)
              Text(
                _trueAnswerText().toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            SizedBox(
              width: 5.sp,
            ),
          ],
        ),
        explanation != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: ColorManager.primary,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      const Text(
                        'التفسير : ',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    explanation,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                ],
              )
            : const SizedBox()
      ],
    ),
  );
}

class QuestionWidget extends StatefulWidget {
  final Question question;
  final bool showAnswer;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.showAnswer,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<bool> _selectedAnswers = [];
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _selectedAnswers =
        List.generate(widget.question.answers.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: TextStyle(
                fontSize: 18.sp, fontWeight: FontWeightManager.bold),
          ),
          SizedBox(height: 10.sp),
          ...List.generate(widget.question.answers.length, (index) {
            return _buildChoice(index);
          }),
          SizedBox(height: 10.sp),
          if (widget.showAnswer)
            answerBuilder(
                trueAnswer: widget.question.trueAnswer, isCorrect: _isCorrect),
        ],
      ),
    );
  }

  Widget _buildChoice(int index) {
    Color borderColor = Colors.grey;
    Color textColor = Colors.black;
    Color backgroundColor = ColorManager.white;

    if (widget.showAnswer) {
      if (_selectedAnswers[index]) {
        if (widget.question.trueAnswer.contains(index)) {
          borderColor = ColorManager.green;
          textColor = ColorManager.white;
          backgroundColor = ColorManager.green;
        } else {
          borderColor = ColorManager.error;
          textColor = ColorManager.white;
          backgroundColor = ColorManager.error;
        }
      } else {
        if (widget.question.trueAnswer.contains(index)) {
          borderColor = ColorManager.green;
          textColor = ColorManager.green;
        } else {
          borderColor = Colors.grey;
          textColor = Colors.black;
        }
      }
    } else {
      if (_selectedAnswers[index]) {
        borderColor = ColorManager.primary;
        textColor = ColorManager.white;
        backgroundColor = ColorManager.primary;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!widget.showAnswer) {
          setState(() {
            if (widget.question.trueAnswer.length == 1) {
              _selectedAnswers =
                  List.generate(widget.question.answers.length, (_) => false);
              _selectedAnswers[index] = true;
            } else {
              _selectedAnswers[index] = !_selectedAnswers[index];
            }
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
        margin: EdgeInsets.symmetric(vertical: 5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: borderColor),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.showAnswer && widget.question.trueAnswer.contains(index))
              Padding(
                padding: EdgeInsetsDirectional.only(end: 2.sp),
                child: Icon(Icons.check_circle, color: ColorManager.green),
              ),
            Expanded(
              child: Text(
                widget.question.answers[index],
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
