import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:BeWell/modules/main/data_layer/models/course_models.dart';

import '../../domain_layer/entities/course.dart';

abstract class BaseMainRemoteDataSource {
  Future<Either<Exception, List<Course>>> getCourses();
}

class MainRemoteDataSource extends BaseMainRemoteDataSource {
  @override
  Future<Either<Exception, List<Course>>> getCourses() async {
    try{
      List<Course> courseModel = [];
      await FirebaseFirestore.instance.
      collection("course").get().then((value) {
        for(var element in value.docs){
          courseModel.add(CourseModel.fromJson(element.data()));
        }
      });
      return Right(courseModel);
    }on FirebaseException catch (error) {
      return Left(error);
    }
  }
}
