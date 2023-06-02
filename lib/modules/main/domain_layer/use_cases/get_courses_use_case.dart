import 'package:dartz/dartz.dart';
import '../entities/course.dart';
import '../repositories/base_main_repository.dart';

class GetCoursesUseCase {
  final BaseMainRepository baseMainRepository;
  GetCoursesUseCase(this.baseMainRepository);
  Future<Either<Exception, List<Course>>> get() {
    return baseMainRepository.getCourses();
  }
}
