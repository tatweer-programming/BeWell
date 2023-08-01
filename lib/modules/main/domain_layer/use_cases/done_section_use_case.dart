import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_main_repository.dart';

class DoneSectionUseCase {
  final BaseMainRepository baseMainRepository;
  DoneSectionUseCase(this.baseMainRepository);
  Future<Either<Exception, void>> done({
    required String courseName,
    required Section section,
    required int progress,
    required int done,
  }) {
    return baseMainRepository.doneSection(
        courseName: courseName, section: section ,done: done, progress: progress);
  }
}
