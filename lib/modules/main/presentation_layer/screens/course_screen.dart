import 'package:BeWell/core/utils/color_manager.dart';
 import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constance_manager.dart';
import '../bloc/main_bloc.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = MainBloc.get(context)..add(GetProgressEvent());
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.sp),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      HexColor("#DC7633"),
                      ColorManager.primary,
                      HexColor("#EB984E"),
                      HexColor("#F0B27A"),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحبا',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: FontSizeManager.s18.sp,
                          ),
                        ),
                        Text(
                          ConstantsManager.studentName,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeManager.s22.sp,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_on,
                        color: ColorManager.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الدورات المتاحة",
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeManager.s22.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            bloc.courses.length,
                                (courseIndex) => courseBuilder(
                              course: bloc.courses[courseIndex],
                              context: context,
                              courseIndex: courseIndex,
                              bloc: bloc,
                              lessonsLength: bloc.courses[courseIndex].lessons.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
