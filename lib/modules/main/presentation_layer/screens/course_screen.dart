import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/modules/main/data_layer/models/course_models.dart';
import 'package:BeWell/modules/main/data_layer/models/lesson_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/lesson.dart';
import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:sizer/sizer.dart';

import '../../data_layer/models/section_model.dart';
import '../../domain_layer/entities/course.dart';
import '../bloc/main_bloc.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      return const Scaffold();
    });
  }
}
