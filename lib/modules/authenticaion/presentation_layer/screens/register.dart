import 'package:BeWell/modules/authenticaion/presentation_layer/screens/forget_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../bloc/auth_bloc.dart';
import '../components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    AuthBloc bloc = sl();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
       if (state is SendAuthRequestSuccessfulState )
       {
         emailController.clear();
         nameController.clear();
         idController.clear();
         passwordController.clear();

       }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(),

          body: Padding(
            padding: EdgeInsets.all(8.0.sp),
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
                            'انشاء حساب',
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary,
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          defaultFormField(
                              label: 'الاسم رباعي',
                              controller: nameController,
                              validator: (value) {
                                if (value == '') {
                                  return 'من فضلك أدخل البريد الالكتروني';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 10.sp,
                          ),
                          defaultFormField(
                              label: 'كود الطالب',
                              controller: idController,
                              validator: (value) {
                                if (value == '') {
                                  return 'من فضلك أدخل الكود';
                                }
                              }),
                          SizedBox(
                            height: 10.sp,
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
                              }),
                          SizedBox(
                            height: 12.sp,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 40.sp,
                              child: defaultButton
                                (
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(
                                          SendAuthRequestEvent(
                                              context: context,
                                              id: idController.text,
                                              password: passwordController
                                                  .text,
                                              email: emailController.text,
                                              name: nameController.text));
                                    }
                                  },
                                  text: 'انشئ حساب')),


                        ],
                      ),
                    ),
                  ),
                  Align(alignment: AlignmentDirectional.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تمتلك حساب بالفعل ؟'),
                        TextButton(onPressed: () {
                          NavigationManager.pop(context);
                        }, child: Text('تسجيل الدخول'))
                      ],
                    ),)
                ],
              ),
            ),
          ),
        );

      },
    );
  }
}
