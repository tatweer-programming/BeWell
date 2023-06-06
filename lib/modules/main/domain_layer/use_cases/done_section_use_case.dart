import 'package:dartz/dartz.dart';
import '../entities/course.dart';
import '../repositories/base_main_repository.dart';

class DoneSectionUseCase {
  final BaseMainRepository baseMainRepository;
  DoneSectionUseCase(this.baseMainRepository);
  Future<Either<Exception, void>> done({
    required String courseName,
    required double progress,
    required int done,
  }) {
    return baseMainRepository.doneSection(
        courseName: courseName,done:done, progress: progress);
  }
}