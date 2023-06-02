import 'package:equatable/equatable.dart';

class Question extends Equatable {
  List<String> answers;
  int trueAnswer;
  String question;
  int marks;
  Question(
      {required this.answers,
      required this.question,
      required this.trueAnswer,
      this.marks = 1});

  @override
  List<Object?> get props => [answers, trueAnswer, question, marks];
}
