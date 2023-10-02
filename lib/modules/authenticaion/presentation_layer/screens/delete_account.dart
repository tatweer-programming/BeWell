import 'package:BeWell/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../main/presentation_layer/components/components.dart';
import '../bloc/auth_bloc.dart';
import '../components/components.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
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
            body: Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'حذف الحساب',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultFormField(
                          label: 'البريد الالكتروني',
                          controller: emailController,
                          validator: (value) {
                            if (value == '') {
                              return 'من فضلك أدخل البريد الالكتروني';
                            } else if (!bloc.isValidEmail(value)) {
                              return 'من فضلك أدخل بريد الكتروني صحيح';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      defaultFormField(
                        label: 'كلمة المرور',
                        prefix: Icons.lock_outline,
                        type: bloc.oldType,
                        obscureText: bloc.oldVisibility,
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
                      defaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(DeleteUserEvent(email: emailController.text, password: passwordController.text,context: context));
                            }
                          },
                          text: "حذف")
                    ]),
              ),
            ));
      },
    );
  }
}
