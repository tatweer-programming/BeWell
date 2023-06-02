import 'package:dartz/dartz.dart';
import '../entities/course.dart';

abstract class BaseMainRepository
{
  Future<Either<Exception, List<Course>>> getCourses();
}