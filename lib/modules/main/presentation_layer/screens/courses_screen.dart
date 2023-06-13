import 'dart:math';
import 'package:BeWell/core/utils/color_manager.dart';
 import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/profile_screen.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/constance_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../bloc/main_bloc.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = sl();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        // if (state is GetCoursesSuccessState) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     int i = Random().nextInt(bloc.doneSection!.dailyReminder.length);
        //     print(i);
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text(
        //             bloc.doneSection!.dailyReminder[i].title,
        //           ),
        //           content: SingleChildScrollView(
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 imageScreen(
        //                     image: bloc.doneSection!.dailyReminder[i].image),
        //               ],
        //             ),
        //           ),
        //           actions: [
        //             TextButton(
        //               child: const Text("إغلاق"),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           ],
        //         );
        //       },
        //     );
        //   });
        // }
        return Builder(
          builder: (BuildContext context) {
            return Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                      ),
                      child: Text(
                        'BeWell',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: FontSizeManager.s22.sp,
                          fontWeight: FontWeightManager.bold
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("الصفحة الشخصية",
                        style: TextStyle(
                            fontSize: FontSizeManager.s17.sp,
                            fontWeight: FontWeightManager.bold
                        ),
                      ),
                      onTap: () {
                        NavigationManager.push(context, const ProfileScreen());
                      },
                    ),
                    ListTile(
                      title: Text("تسجيل الخروج",
                        style: TextStyle(
                            fontSize: FontSizeManager.s17.sp,
                            fontWeight: FontWeightManager.bold
                        ),),
                      onTap: () {
                        bloc.add(LogOutEvent(
                          context: context
                        ));
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30.h,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: ColorManager.white,
                            size: 25.sp,
                          ),
                        ),
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
      },
    );
  }
}
