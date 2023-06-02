import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Section extends Equatable {
  QuizModel? quiz;
  String? sectionImage;
  String? videoId;
  Video? video;
  Section({
    this.quiz,
    this.sectionImage,
    this.videoId,
    this.video,
  });

  @override
  List<Object?> get props => [quiz, sectionImage, videoId, video];
}
