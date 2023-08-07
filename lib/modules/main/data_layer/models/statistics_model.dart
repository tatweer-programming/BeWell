
import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';

import '../../domain_layer/entities/statistics.dart';
//ignore: must_be_immutable
class StatisticsModel extends Statistics {
  StatisticsModel(
      {super.quiz,
      super.sectionName});

  factory StatisticsModel.fromJson({
    required String key,
    required dynamic value,
}) {
    return StatisticsModel(
      sectionName: key,
      quiz: QuizModel.fromJson(value),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      sectionName!: quiz?.toJson(),
    };
  }
}
