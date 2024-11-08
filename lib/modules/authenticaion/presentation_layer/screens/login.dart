import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/forget_password.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/register.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../main/presentation_layer/components/components.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = sl();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary,
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
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
                            height: 10.sp,
                          ),
                          defaultFormField(
                              label: 'كلمة المرور',
                              controller: passwordController,
                              validator: (value) {
                                if (value == '') {
                                  return 'من فضلك أدخل كلمة المرور';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.sp,
                          ),
                          state is! LoginLoadingAuthState ?
                          SizedBox(
                              width: double.infinity,
                              height: 40.sp,
                              child: defaultButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(LoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          context: context));
                                    }
                                  },
                                  text: 'تسجيل الدخول')):
                          const Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  NavigationManager.push(
                                      context, const ForgetPasswordScreen());
                                },
                                child: const Text('هل نسيت كلمة المرور؟ ')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('الا تمتلك حساب ؟'),
                        TextButton(
                            onPressed: () {
                              NavigationManager.push(
                                  context, const RegisterScreen());
                            },
                            child: const Text('انشئ حساب'))
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          ConstantsManager.studentName = "تجربة التطبيق ";
                          NavigationManager.push(
                              context, const CoursesScreen());
                        },
                        child: const Text('تجربة التطبيق ')),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
