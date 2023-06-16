import 'package:equatable/equatable.dart';

class SurveyQuestion extends Equatable {
final String question ;
final int minAnswer ;
final int maxAnswer ;

 const SurveyQuestion({required this.question, this.minAnswer = 0, required this.maxAnswer});
  @override
  List<Object?> get props =>
      [question , minAnswer , maxAnswer];
}