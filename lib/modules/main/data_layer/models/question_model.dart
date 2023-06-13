import 'package:BeWell/modules/main/domain_layer/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.question,
    required super.trueAnswer,
    required super.answers,
  });

  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      trueAnswer: List<int>.from(json['trueAnswer']).map((e) => e).toList(),
      answers: List<String>.from(json['answers']).map((e) => e).toList(),
    );
  }
}
