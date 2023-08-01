
import '../../domain_layer/entities/statistics.dart';
//ignore: must_be_immutable
class StatisticsModel extends Statistics {
  StatisticsModel(
      {super.quiz,
      required super.sectionName});
  Map<String, dynamic> toJson() {
    return {
      "quiz": quiz?.toJson(),
      "sectionName":sectionName,
    };
  }
}
