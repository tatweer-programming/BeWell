import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:BeWell/modules/main/presentation_layer/bloc/main_bloc.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/services/dep_injection.dart';

class TestQuizScreen extends StatelessWidget {
  final List<Question> questions;
  const TestQuizScreen({Key? key,required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = sl();
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(
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
                          showAnswer: bloc.showAnswer,
                          questionNumber: index + 1),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.sp,
                          ),
                      itemCount: questions.length),
                ),
              ),
              defaultButton(
                  onPressed: () {
                    bloc.add(ShowQuizAnswerEvent());
                  },
                  text: "إظهار الإجابات"
              ),
              SizedBox(height: 2.h,)
            ],
          );
        },
      ),
    );
  }
}

