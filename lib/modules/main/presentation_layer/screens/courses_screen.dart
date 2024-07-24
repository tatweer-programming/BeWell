import 'dart:math';
import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/delete_account.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/login.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/profile_screen.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/register.dart';
import 'package:BeWell/modules/main/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/constance_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../authenticaion/presentation_layer/screens/change_password.dart';
import '../bloc/main_bloc.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = sl();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (ConstantsManager.userId != null && ConstantsManager.lastDailyReminder &&
            bloc.dailyReminder.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            int i = Random().nextInt(bloc.dailyReminder.length);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "time to stand and move a little for one minute ",
                        textDirection: TextDirection.ltr,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        bloc.dailyReminder[i].title,
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        imageScreen(
                            height: 30.h, image: bloc.dailyReminder[i].image),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        "إغلاق",
                        style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeightManager.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            await CacheHelper.saveData(
                key: "dailyReminder", value: DateTime.now().toString());
            ConstantsManager.lastDailyReminder = false;
          });
        }
        return Builder(
          builder: (BuildContext context) {
            return Scaffold(
              endDrawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                      ),
                      child: Center(
                        child: Text(
                          'BeWell',
                          style: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSizeManager.s22.sp,
                              fontWeight: FontWeightManager.bold),
                        ),
                      ),
                    ),
                    ConstantsManager.userId != null ? Column(
                      children: [
                        ListTile(
                          title: Text(
                            "الصفحة الشخصية",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () async {
                            await CacheHelper.getData(key: 'waterCups').then((value){
                              ConstantsManager.waterCups = value;
                              NavigationManager.push(context, const ProfileScreen());
                            });
                          },
                        ),
                        ListTile(
                          title: Text(
                            "تغير كلمة المرور",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () {
                            NavigationManager.push(context, const ChangePassword());
                          },
                        ),
                        ListTile(
                          title: Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () {
                            bloc.add(LogOutEvent(context: context));
                          },
                        ),
                        ListTile(
                          title: Text(
                            "حذف الحساب",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () {
                            NavigationManager.push(context, const DeleteAccount());
                          },
                        ),
                      ],
                    ) :
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () {
                            NavigationManager.push(context, const LoginScreen());
                          },
                        ),
                        ListTile(
                          title: Text(
                            "إنشاء الحساب",
                            style: TextStyle(
                                fontSize: FontSizeManager.s17.sp,
                                fontWeight: FontWeightManager.bold),
                          ),
                          onTap: () {
                            NavigationManager.push(context, const RegisterScreen());
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              body: state is! GetProgressLoadingState ||
                      state is! GetCoursesLoadingState
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(30.sp),
                                  bottomStart: Radius.circular(30.sp)),
                              color: ColorManager.secondary,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'مرحبا',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSizeManager.s18.sp,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          return IconButton(
                                            onPressed: () {
                                              Scaffold.of(context).openEndDrawer();
                                            },
                                            icon: Icon(
                                              Icons.menu,
                                              color: ColorManager.white,
                                              size: 25.sp,
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  ConstantsManager.studentName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizeManager.s22.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
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
                                GridView.count(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5.sp,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: ColorManager.secondary,
                    )),
            );
          },
        );
      },
    );
  }
}
