// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maths_corn_student/modules/authenticaion/presentation_layer/components/components.dart';
// import 'package:maths_corn_student/modules/authenticaion/presentation_layer/screens/register.dart';
// import 'package:maths_corn_student/modules/main/presentation_layer/screens/main_screen.dart';
// import 'package:rive/rive.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../core/utils/color_manager.dart';
// import '../../../../core/utils/navigation_manager.dart';
// import '../bloc/auth_bloc.dart';
// import 'forget_password.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     var bloc = AuthBloc.get(context);
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is LoginSuccessfulAuthState) {
//           state.check.fire();
//           Future.delayed(const Duration(seconds: 2), () {
//             bloc.add(const ChangeIsLoadingEvent(false));
//             state.confetti.fire();
//             Future.delayed(const Duration(seconds: 1 ,milliseconds: 5),(){
//               NavigationManager.pushAndRemove(context, const MainScreen());
//             });
//           });
//         }
//         else if (state is LoginErrorAuthState) {
//           state.error.fire();
//           Future.delayed(const Duration(seconds: 2), () {
//             bloc.add(const ChangeIsLoadingEvent(false));
//           });
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SingleChildScrollView(
//               child: Stack(
//             children: [
//               Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: 200.sp,
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/images/board.jpg',
//                             fit: BoxFit.fill,
//                             height: 200.sp,
//                             width: double.infinity,
//                           ),
//                           Center(
//                             child: SizedBox(
//                               height: 190.sp,
//                               child: Image.asset(
//                                 "assets/images/auth_2.png",
//                                 fit: BoxFit.fill,
//                                 height: 100.sp,
//                                 width: double.infinity,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(20.sp),
//                       child: Column(
//                         children: [
//                           Text(
//                             'تسجيل الدخول',
//                             style: TextStyle(
//                                 fontSize: 20.sp, fontWeight: FontWeight.w900),
//                           ),
//                           SizedBox(
//                             height: 20.sp,
//                           ),
//                           defaultFormField(
//                             label: 'الإيميل',
//                             type: TextInputType.emailAddress,
//                             prefix: Icons.email_outlined,
//                             controller: emailController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'يجب عليك ان تكتب الإيميل !';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 15.sp,
//                           ),
//                           defaultFormField(
//                             label: 'كلمة المرور',
//                             prefix: Icons.lock_outline,
//                             type: bloc.oldType,
//                             controller: passwordController,
//                             suffix: IconButton(
//                                 onPressed: () {
//                                   bloc.add(const OldChangeVisibilityEvent());
//                                 },
//                                 icon: Icon(
//                                   bloc.oldSuffix,
//                                 )),
//                             obscureText: bloc.oldVisibility,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'يجب عليك ان تكتب كلمة المرور !';
//                               }
//                               return null;
//                             },
//                           ),
//                           Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                   onPressed: () {
//                                     bloc.add(
//                                         NavigationToForgetPasswordScreenEvent(
//                                             context: context));
//                                   },
//                                   child: Text(
//                                     'هل نسيت كلمة المرور ؟',
//                                     style: TextStyle(
//                                       color: ColorManager.black,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 15.sp,
//                                     ),
//                                   ))),
//                           SizedBox(
//                             height: 10.sp,
//                           ),
//                           State is! LoginLoadingAuthState
//                               ? defaultButton(
//                                   onPressed: () {
//                                     bloc.add(const ChangeIsLoadingEvent(true));
//                                     Future.delayed(const Duration(seconds: 2),
//                                         () {
//                                       if (formKey.currentState!.validate()) {
//                                         bloc.add(LoginEvent(
//                                             email: emailController.text,
//                                             password: passwordController.text,
//                                             context: context));
//                                       } else {
//                                         bloc.error.fire();
//                                         Future.delayed(
//                                             const Duration(seconds: 2), () {
//                                           bloc.add(const ChangeIsLoadingEvent(
//                                               false));
//                                         });
//                                       }
//                                     });
//                                   },
//                                   text: "تسجيل الدخول",
//                                   textColor: ColorManager.white,
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               : const Center(
//                                   child: CircularProgressIndicator()),
//                           SizedBox(
//                             height: 15.sp,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text("لا يوجد لديك حساب ؟"),
//                               TextButton(
//                                   onPressed: () {
//                                     bloc.add(NavigationToRegisterScreenEvent(
//                                         context: context));
//                                   },
//                                   child: Text(
//                                     'إنشاء حساب',
//                                     style:
//                                         TextStyle(color: ColorManager.primary),
//                                   ))
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               bloc.isShowLoading
//                   ? CustomPositioned(
//                       child: RiveAnimation.asset(
//                         "assets/rive/check.riv",
//                         onInit: (artboard) {
//                           bloc.add(CheckEvent(artboard: artboard));
//                         },
//                       ),
//                     )
//                   : const SizedBox(),
//               CustomPositioned(
//                 child: Transform.scale(
//                   scale: 7,
//                   child: RiveAnimation.asset(
//                     "assets/rive/confetti.riv",
//                     onInit: (artboard) {
//                       bloc.add(ConFettiEvent(artboard: artboard));
//                     },
//                   ),
//                 ),
//               )
//             ],
//           )),
//         );
//       },
//     );
//   }
// }
