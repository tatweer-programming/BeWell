import 'package:equatable/equatable.dart';
//ignore: must_be_immutable
class Question extends Equatable {
  final String question;
  final List<int> trueAnswer;
  final List<String> answers;
  Map<String, dynamic>? studentsGrades = {};
  Question({
    required this.question,
    required this.trueAnswer,
    required this.answers,
    this.studentsGrades,
  });
  @override
  List<Object?> get props => [
        question,
        answers,
        trueAnswer,
        studentsGrades,
      ];
}
