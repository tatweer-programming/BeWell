import '../../domain_layer/entities/section.dart';

//ignore: must_be_immutable
class SectionsModel extends Sections{
  SectionsModel({
    super.videoId,
    super.sectionImage,
    super.examId,
  });
  factory SectionsModel.fromJson(Map<String, dynamic> json) =>
      SectionsModel(
          examId: json['examId'],
          sectionImage: json['sectionImage'],
          videoId: json['videoId']
      );

  Map<String, dynamic> toJson() {
    return {
      "examId": examId,
      "videoId":videoId,
      "sectionImage":sectionImage,
    };
  }
}