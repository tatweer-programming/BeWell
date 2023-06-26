import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../main/presentation_layer/components/components.dart';
import '../bloc/auth_bloc.dart';
import '../components/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var oldPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    AuthBloc bloc = sl();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorManager.white,
              iconTheme: IconThemeData(color: ColorManager.black),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "معدل الدورات",
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        ConstantsManager
                            .doneSection != null && ConstantsManager
                            .doneSection!.progress.isEmpty ?
                            Text("لم تقم بالبدأ في اي دورات بعد ",
                            style: TextStyle(
                              fontSize: FontSizeManager.s15.sp
                            ),)
                            :ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => progress(
                                  courseName: ConstantsManager
                                      .doneSection!.progress.keys
                                      .toList()[index],
                                  percent: (ConstantsManager
                                      .doneSection!.progress.values
                                      .toList()[index].round().toString()),
                                ),
                            separatorBuilder: (context, index) => Container(
                                  height: 0.5.h,
                                  color: ColorManager.card,
                                ),
                            itemCount:ConstantsManager
                                .doneSection != null ? ConstantsManager
                                .doneSection!.progress.values.length:0),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("عدد اكواب المياه",
                              style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 20.sp),
                            ),
                            Text(
                              ConstantsManager.waterCups == null ? "0" : ConstantsManager.waterCups.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 20.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'تغير كلمة المرور ',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        defaultFormField(
                          label: 'كلمة المرور',
                          prefix: Icons.lock_outline,
                          // suffix: IconButton(
                          //     onPressed: () {
                          //       bloc.add(const OldChangeVisibilityEvent());
                          //     },
                          //     icon: Icon(bloc.oldSuffix,
                          //     )),
                          type: bloc.oldType,
                          obscureText: bloc.oldVisibility,
                          controller: oldPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل كلمة المرور ';
                            }
                            if (passwordController.text ==
                                oldPasswordController.text) {
                              return 'كلمة المرور القديمة هي نفس كلمة المرور الجديدة ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        defaultFormField(
                          label: 'كلمة المرور الجديده',
                          prefix: Icons.lock_outline,
                          // suffix: IconButton(
                          //     onPressed: () {
                          //       bloc.add(const ChangeVisibilityEvent());
                          //     },
                          //     icon: Icon(bloc.newSuffix,
                          //     ),
                          // ),
                          type: bloc.newType,
                          obscureText: bloc.newVisibility,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل كلمة المرور ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        defaultFormField(
                          label: 'تأكيد كلمة المرور الجديده',
                          prefix: Icons.lock_outline,
                          obscureText: true,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                passwordController.text !=
                                    confirmPasswordController.text) {
                              return 'من فضلك تأكد من كتابة كلمة المرور ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                bloc.add(ChangePassEvent(
                                    context: context,
                                    newPassword: passwordController.text,
                                    oldPassword: oldPasswordController.text));
                              }
                            },
                            text: "تغير")
                      ]),
                ),
              ),
            ));
      },
    );
  }
}
