import 'package:dartz/dartz.dart';

import '../../domain_layer/entities/course.dart';
import '../../domain_layer/repositories/base_main_repository.dart';
import '../data_sources/main_remote_data_source.dart';

class MainRepository extends BaseMainRepository {
  BaseMainRemoteDataSource baseMainRemoteDataSource;
  MainRepository(this.baseMainRemoteDataSource);
  @override
  Future<Either<Exception, List<Course>>> getCourses() async {
    return await baseMainRemoteDataSource.getCourses();
  }
}