import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/lessons_screen.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/seections_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/language_manager.dart';
import '../../../../core/utils/numbers_manager.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/lesson.dart';
import '../../domain_layer/entities/section.dart';
import '../../domain_layer/entities/survey.dart';
import '../../domain_layer/entities/survey_question.dart';
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
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(5.sp),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: ColorManager.card,
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      image: NetworkImage(course.courseImage),
                      fit: BoxFit.cover,
                    )),
            ),
            Container(
              height: 10.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(.7),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    course.courseName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: FontSizeManager.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Text(
                    "${NumbersManager.engNumberToArabic("${course.lessons.length}")} دروس ",
                    style: TextStyle(
                      fontSize: FontSizeManager.s12.sp,
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ],
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
  if (bloc.doneSection != null &&
      bloc.doneSection!.done[course.courseName] != null) {
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.sp,
                          ),
                          Text(
                            lesson.lessonName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                    ),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.lessonName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
              ),
              if (bloc.prefixLesson[lessonIndex] > counter)
                Icon(
                  Icons.lock,
                  color: ColorManager.secondary,
                )
              else if (course.lessons[lessonIndex].sections.length <= counter)
                Icon(
                  Icons.check_circle_rounded,
                  color: ColorManager.secondary,
                )
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
  if (bloc.doneSection != null &&
      bloc.doneSection!.done[course.courseName] != null) {
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
              Expanded(
                child: Text(
                  section.sectionName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSizeManager.s15.sp),
                ),
              ),
              if (bloc.prefixLesson[lessonIndex] + sectionsIndex > counter)
                Icon(
                  Icons.lock,
                  color: ColorManager.secondary,
                )
              else if (bloc.prefixLesson[lessonIndex] + sectionsIndex < counter)
                Icon(
                  Icons.check_circle_rounded,
                  color: ColorManager.secondary,
                )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget questionScreen({
  required List<Question> questions,
}) {
  MainBloc bloc = sl();
  return BlocBuilder<MainBloc, MainState>(
    builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => QuestionWidget(
                        question: questions[index],
                        showAnswer: bloc.showAnswer, index: index,questionLength: questions.length
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.sp,
                      ),
                  itemCount: questions.length),
            ),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      );
    },
  );
}

Widget imageScreen({
  required String image,
  required double height,
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
          height: height,
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
              child: LanguageManager.formatText(text)
            ),
          ),
        ],
      ),
    ),
  );
}

Widget answerBuilder(
    {required List<int> trueAnswer,
    required List<String> answers,
    required bool isCorrect}) {
  List<String> trueAnswerText() {
    List<String> trueAnswerText = [];
    for (var element in trueAnswer) {
      trueAnswerText.add(answers[element]);
    }
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
            trueAnswerText().toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        SizedBox(
          width: 5.sp,
        ),
      ],
    ),
  );
}

class QuestionWidget extends StatefulWidget {
  final Question question;
  final bool showAnswer;
  final int index;
  final int questionLength;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.showAnswer,
    required this.index,
    required this.questionLength,
  });

  @override
  QuestionWidgetState createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {
  List<bool> _selectedAnswers = [];
  List<int> _selectedAnswersIndexes = [];
  final bool _isCorrect = false;
  MainBloc bloc = sl();

  @override
  void initState() {
    super.initState();
    _selectedAnswers =
        List.generate(widget.question.answers.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Text(
                widget.question.question,
                style:
                TextStyle(fontSize: 18.sp, fontWeight: FontWeightManager.bold),
              ),
              SizedBox(height: 10.sp),
              ...List.generate(widget.question.answers.length, (index) {
                return _buildChoice(index);
              }),
              SizedBox(height: 10.sp),
              if (widget.showAnswer)
                answerBuilder(
                    trueAnswer: widget.question.trueAnswer,answers: widget.question.answers, isCorrect: _isCorrect),
            ],
          ),
        ),
        if(widget.index == widget.questionLength-1 && _selectedAnswersIndexes.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10.sp),
            child: defaultButton(
                onPressed: () {
                  if(ConstantsManager.userId == null) {
                    errorToast(msg: "يجب عليك إنشاء حساب اولا لتتمكن من إستكمال الدورة");
                  } else {
                    bloc.add(ShowQuizAnswerEvent());
                  }
                },
                text: "إظهار الإجابات"),
          ),
      ],
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
              if(_selectedAnswersIndexes.contains(index)) {
                _selectedAnswersIndexes.remove(index);
              } else {
                _selectedAnswersIndexes.add(index);
              }
              widget.question.studentsGrades = {ConstantsManager.studentName! : _selectedAnswersIndexes};
            } else {
              _selectedAnswers[index] = !_selectedAnswers[index];
              if(_selectedAnswersIndexes.contains(index)) {
                _selectedAnswersIndexes.remove(index);
              } else {
                _selectedAnswersIndexes.add(index);
              }
              widget.question.studentsGrades = {ConstantsManager.studentName! : _selectedAnswersIndexes};
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

//ignore: must_be_immutable
class SurveyScreen extends StatefulWidget {
  final Survey survey;
  MainBloc bloc = sl();

  SurveyScreen({
    super.key,
    required this.survey,
  });

  @override
  SurveyScreenState createState() => SurveyScreenState();
}

class SurveyScreenState extends State<SurveyScreen> {
  List<int> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.survey.questions.length, 0);
  }

  void _onQuestionAnswered(int index, int value) {
    setState(() {
      selectedAnswers[index] = 8 - value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.survey.questions.length,
            itemBuilder: (context, index) {
              final question = widget.survey.questions[index];
              return SurveyQuestionWidget(
                question: question,
                onAnswered: (value) => _onQuestionAnswered(index, value),
              );
            },
          ),
          if (widget.bloc.showResult)
            Card(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                ),
                child: Text(_getMessage(widget.survey.result,
                    selectedAnswers.reduce((a, b) => a + b)),
                  textDirection: LanguageManager.isTextArabic(_getMessage(widget.survey.result,
                      selectedAnswers.reduce((a, b) => a + b)))? TextDirection.rtl :TextDirection.ltr,
                ),
              ),
            ),
          SizedBox(
            height: 2.h,
          ),
          defaultButton(
              onPressed: () {
                setState(() {
                  widget.bloc.add(ShowSurveyAnswerEvent());
                });
              },
              text: "إظهار النتيجة"),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }

  String _getMessage(Map<List<int>, String> result, int degree) {
    String message = '';
    for (var element in result.keys) {
      if ((degree >= element[0] && degree <= element[1]) ||
          (degree >= element[1] && degree < element[0])) {
        message = result[element] ?? '';
      }
    }
    return message;
  }
}

class SurveyQuestionWidget extends StatefulWidget {
  final SurveyQuestion question;
  final Function(int)? onAnswered;

  const SurveyQuestionWidget(
      {super.key, required this.question, this.onAnswered});

  @override
  SurveyQuestionWidgetState createState() => SurveyQuestionWidgetState();
}

class SurveyQuestionWidgetState extends State<SurveyQuestionWidget> {
  int _selectedAnswer = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.question.question,
            textDirection: LanguageManager.isTextArabic(widget.question.question)? TextDirection.rtl :TextDirection.ltr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          SizedBox(height: 10.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.question.maxAnswer - widget.question.minAnswer + 1,
                (index) {
                  int value = index + widget.question.minAnswer;
                  return Padding(
                    padding: EdgeInsets.all(1.5.sp),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAnswer = value;
                        });
                        widget.onAnswered?.call(_selectedAnswer);
                      },
                      child: Container(
                        width: 30.sp,
                        height: 30.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedAnswer == value
                              ? ColorManager.primary
                              : ColorManager.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: _selectedAnswer == value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
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
