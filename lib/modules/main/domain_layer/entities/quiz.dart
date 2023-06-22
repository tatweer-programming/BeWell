import 'package:BeWell/modules/main/data_layer/models/question_model.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Quiz extends Equatable {
  List<QuestionModel> questions;
  Quiz({
    required this.questions,
  });
  @override
  List<Object?> get props => [questions];
}
