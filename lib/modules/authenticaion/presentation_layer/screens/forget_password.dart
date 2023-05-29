// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../core/utils/color_manager.dart';
// import '../../../../core/utils/navigation_manager.dart';
// import '../../../../core/utils/values_manager.dart';
// import '../bloc/auth_bloc.dart';
// import '../components/components.dart';
//
// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var bloc = AuthBloc.get(context);
//     GlobalKey<FormState> formKey = GlobalKey<FormState>();
//     TextEditingController emailController = TextEditingController();
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if(state is SendEmailSuccessfulAuthState){
//           defaultToast(msg: "من فضلك تحقق من الإيميل ثم يجب عليك إعادة تعيين كلمة المرور");
//           Future.delayed(const Duration(seconds: 5), () {
//             bloc.add(NavigationToLoginScreenEvent(context: context));
//           });
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   vertical: 35.sp, horizontal: 15.sp),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         height: 60.sp,
//                         child: Align(
//                           alignment: AlignmentDirectional.topStart,
//                           child: IconButton(
//                             onPressed: () {
//                               NavigationManager.pop(context);
//                             },
//                             icon: const Icon(Icons.arrow_back),
//                           ),
//                         )),
//                     Text(
//                       'نسيت كلمة المرور ؟',
//                       style: TextStyle(
//                         color: ColorManager.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30.sp,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.sp,
//                     ),
//                     Text(
//                       'اكتب الايميل وهنبعتلك ايميل لتأكيد حسابك',
//                       style: TextStyle(
//                         color: ColorManager.black,
//                         fontWeight: FontWeight.w200,
//                         fontSize: 15.sp,
//                       ),
//                     ),
//                     SizedBox(height: 5.sp),
//                     defaultFormField(
//                       prefix: Icons.email,
//                       label: 'الايميل',
//                       controller: emailController,
//                       validatorText: "من فضلك اكتب الايميل",
//                     ),
//                     SizedBox(height: 20.sp),
//                     defaultButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 bloc.add(ForgetPasswordAuthEvent(
//                                     email: emailController.text));
//                               }
//                             },
//                             text: "إرسال",)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
