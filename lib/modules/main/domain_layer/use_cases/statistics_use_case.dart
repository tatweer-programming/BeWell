import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_main_repository.dart';

class StatisticsUseCase {
  final BaseMainRepository baseMainRepository;
  StatisticsUseCase(this.baseMainRepository);
  Future<Either<Exception, void>> call({
    required Section section,
  }) {
    return baseMainRepository.statistics(section: section);
  }
}
