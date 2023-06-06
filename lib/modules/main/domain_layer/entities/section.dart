import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

//ignore: must_be_immutable
class Section extends Equatable{
  String? image;
  String? text;
  List<String>? videosIds;
  List<Video>? videos;
  QuizModel? quiz;
  Section({
    this.image,
    this.text,
    this.quiz,
    this.videosIds,
    this.videos,
  });
  @override
  List<Object?> get props => [text,image,videosIds,videos];
}