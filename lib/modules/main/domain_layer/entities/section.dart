import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

//ignore: must_be_immutable
class Sections extends Equatable{
  String? examId;
  String? sectionImage;
  String? videoId;
  Video? video;
  Sections({
    this.examId,
    this.sectionImage,
    this.videoId,
    this.video,
  });
  @override
  List<Object?> get props => [examId,sectionImage,videoId,video];
}