// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maths_corn_student/modules/authenticaion/presentation_layer/components/components.dart';
// import 'package:maths_corn_student/modules/main/presentation_layer/screens/main_screen.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../core/utils/color_manager.dart';
// import '../../../../core/utils/navigation_manager.dart';
// import '../bloc/auth_bloc.dart';
//
// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var nameController = TextEditingController();
//     var emailController = TextEditingController();
//     var studentPhoneController = TextEditingController();
//     var parentPhoneController = TextEditingController();
//     var passwordController = TextEditingController();
//     var confirmPasswordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     var bloc = AuthBloc.get(context);
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is RegisterSuccessAuthState) {
//           bloc.add(const ChangeIsGradeEvent(false));
//           Future.delayed(const Duration(seconds: 1 ,milliseconds: 5),(){
//             NavigationManager.pushAndRemove(context, const MainScreen());
//           });
//         } else if (state is RegisterErrorAuthState) {
//           errorToast(msg: "تأكد من البيانات وحاول مرة اخري");
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
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
//                           Image.asset(
//                             "assets/images/auth_2.png",
//                             fit: BoxFit.cover,
//                             height: 190.sp,
//                             width: double.infinity,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
//                       child: Column(
//                         children: [
//                           Text(
//                             'حساب جديد',
//                             style: TextStyle(
//                                 fontSize: 20.sp, fontWeight: FontWeight.w900),
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                               label: 'الأسم رباعي كامل',
//                               prefix: Icons.person_3_outlined,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'من فضلك اكتب اسمك الرباعي !';
//                                 }
//                                 return null;
//                               },
//                               type: TextInputType.name,
//                               controller: nameController),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                             label: 'الايميل',
//                             prefix: Icons.email_outlined,
//                             type: TextInputType.emailAddress,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'من فضلك اكتب الايميل !';
//                               }
//                               return null;
//                             },
//                             controller: emailController,
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                             label: 'كلمة المرور',
//                             prefix: Icons.lock_outline,
//                             suffix: IconButton(
//                                 onPressed: () {
//                                   bloc.add(const ChangeVisibilityEvent());
//                                 },
//                                 icon: Icon(bloc.newSuffix,
//                                 )),
//                             type: bloc.newType,
//                             obscureText: bloc.newVisibility,
//                             controller: passwordController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'من فضلك اكتب كلمة المرور';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                             label: 'تأكيد كلمة المرور',
//                             prefix: Icons.lock_outline,
//                             obscureText: true,
//                             validator: (value) {
//                               if (value!.isEmpty ||
//                                   passwordController.text !=
//                                       confirmPasswordController.text) {
//                                 return 'من فضلك تأكد من كتابة كلمة المرور مجددا';
//                               }
//                               return null;
//                             },
//                             controller: confirmPasswordController,
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                             label: 'رقم الطالب',
//                             type: TextInputType.phone,
//                             prefix: Icons.phone,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'من فضلك تأكد من كتابة رقم الطالب ';
//                               }
//                               return null;
//                             },
//                             controller: studentPhoneController,
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultFormField(
//                             label: 'رقم ولي الامر',
//                             type: TextInputType.phone,
//                             prefix: Icons.phone,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'من فضلك تأكد من كتابة رقم ولي الامر ';
//                               }
//                               return null;
//                             },
//                             controller: parentPhoneController,
//                           ),
//                           SizedBox(height: 15.sp),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: defaultButton(
//                                 onPressed: () {
//                                   bloc.add(const ChangeIsGradeEvent(true));
//                                   bloc.scrollController =
//                                       FixedExtentScrollController(
//                                           initialItem: bloc.initialItem);
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return BlocBuilder<AuthBloc, AuthState>(
//                                         builder: (context, state) {
//                                           return AlertDialog(
//                                             title: const Text(
//                                                 'اختيار السنة الدراسية',
//                                                 textAlign: TextAlign.center),
//                                             actions: [
//                                               SizedBox(
//                                                 height: 100.sp,
//                                                 child: CupertinoPicker(
//                                                     scrollController:
//                                                         bloc.scrollController,
//                                                     itemExtent: 60.sp,
//                                                     onSelectedItemChanged:
//                                                         (index) {
//                                                       bloc.initialItem = index;
//                                                     },
//                                                     children: bloc.items
//                                                         .map((item) => Center(
//                                                             child: Text(item)))
//                                                         .toList()),
//                                               ),
//                                               TextButton(
//                                                 child:  Text('موافق',style: TextStyle(
//                                                   color: ColorManager.primary
//                                                 ),),
//                                                 onPressed: () {
//                                                   bloc.add(
//                                                       ChooseIndexGradeEvent(
//                                                           index: bloc
//                                                               .initialItem));
//                                                   Navigator.of(context).pop();
//                                                 },
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                                 // height: 5.sp,
//                                 width: MediaQuery.of(context).size.width / 2 - 10.sp,
//                                 buttonColor: ColorManager.white,
//                                 textColor: ColorManager.black,
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w500,
//                                 borderColor:
//                                     ColorManager.black.withOpacity(0.6),
//                                 text: bloc.isGrade
//                                     ? bloc.items[bloc.initialItem]
//                                     : "اختيار السنة الدراسية"),
//                           ),
//                           SizedBox(height: 15.sp),
//                           defaultButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate() &&
//                                   bloc.isGrade) {
//                                 bloc.add(RegisterEvent(
//                                   parentPhone: parentPhoneController.text,
//                                   studentPhone: studentPhoneController.text,
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   name: nameController.text,
//                                   context: context,
//                                   grade: bloc.items[bloc.initialItem],
//                                 ));
//                               } else if (!bloc.isGrade) {
//                                 errorToast(msg: "من فضلك اختر السنةالدراسية");
//                               }
//                               bloc.initialItem = 1;
//                             },
//                             text: "تسجيل",
//                             textColor: ColorManager.white,
//                           ),
//                           SizedBox(height: 10.sp),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text("يوجد لديك حساب بالفعل ؟"),
//                               TextButton(
//                                   onPressed: () {
//                                     bloc.add(NavigationToLoginScreenEvent(
//                                       context: context,
//                                     ));
//                                   },
//                                   child: Text(
//                                     'تسجيل الدخول',
//                                     style: TextStyle(
//                                       color: ColorManager.primary,
//                                     ),
//                                   ))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
