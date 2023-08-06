
import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';

import '../../domain_layer/entities/statistics.dart';
//ignore: must_be_immutable
class StatisticsModel extends Statistics {
  StatisticsModel(
      {super.quiz,
      super.sectionName});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      quiz: QuizModel.fromJson(json[dynamic]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      sectionName!: quiz?.toJson(),
    };
  }
}
