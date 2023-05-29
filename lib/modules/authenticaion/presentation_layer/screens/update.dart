// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maths_corn_student/modules/authenticaion/presentation_layer/components/components.dart';
// import 'package:sizer/sizer.dart';
// import '../bloc/auth_bloc.dart';
//
// class UpdateScreen extends StatelessWidget {
//   const UpdateScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var nameController = TextEditingController();
//     var emailController = TextEditingController();
//     var studentPhoneController = TextEditingController();
//     var parentPhoneController = TextEditingController();
//     var oldPasswordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     var bloc = AuthBloc.get(context)..add(const GetMyDataEvent());
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         if (state is GetMyDataSuccessState) {
//           nameController.text = bloc.userModel!.name;
//           emailController.text = bloc.userModel!.email;
//           studentPhoneController.text = bloc.userModel!.studentPhone;
//           parentPhoneController.text = bloc.userModel!.parentPhone;
//         }
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.white10,
//             iconTheme: const IconThemeData(color: Colors.black),
//           ),
//           body: state is! GetMyDataLoadingState
//               ? Center(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.all(20.0.sp),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'تعديل حسابك ',
//                                 style: TextStyle(
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w900),
//                               ),
//                               SizedBox(
//                                 height: 20.sp,
//                               ),
//                               defaultFormField(
//                                   label: 'الاسم',
//                                 prefix: Icons.person_3_outlined,
//                                 type: TextInputType.name,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'من فضلك اكتب اسمك';
//                                   }
//                                   return null;
//                                 },
//                                 controller: nameController,
//                               ),
//                               SizedBox(
//                                 height: 20.sp,
//                               ),
//                               defaultFormField(
//                                 label: 'رقم الطالب',
//                                 type: TextInputType.phone,
//                                 prefix: Icons.phone,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'من فضلك تأكد من كتابة رقم الطالب ';
//                                   }
//                                   return null;
//                                 },
//                                 controller: studentPhoneController,
//                               ),
//                               SizedBox(height: 20.sp),
//                               defaultFormField(
//                                 label: 'رقم ولي الامر',
//                                 type: TextInputType.phone,
//                                 prefix: Icons.phone,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'من فضلك تأكد من كتابة رقم ولي الامر ';
//                                   }
//                                   return null;
//                                 },
//                                 controller: parentPhoneController,
//                               ),
//                               SizedBox(height: 20.sp),
//
//                               defaultFormField(
//                                 label: 'الايميل',
//                                 prefix: Icons.email_outlined,
//                                 type: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'من فضلك اكتب الايميل';
//                                   }
//                                   return null;
//                                 },
//                                 controller: emailController,
//                               ),
//                               SizedBox(
//                                 height: 20.sp,
//                               ),
//                               defaultFormField(
//                                 label: 'كلمة المرور',
//                                 prefix: Icons.lock_outline,
//                                 suffix: IconButton(
//                                     onPressed: () {
//                                       bloc.add(const OldChangeVisibilityEvent());
//                                     },
//                                     icon: Icon(bloc.oldSuffix,
//                                     )),
//                                 type: bloc.oldType,
//                                 obscureText: bloc.oldVisibility,
//                                 controller: oldPasswordController,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'من فضلك اكتب كلمة المرور';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 2.5.h,
//                               ),
//                               defaultButton(
//                                   onPressed: (){
//                                     bloc.add(UpdateMyDataEvent(
//                                       context: context,
//                                       name: nameController.text,
//                                       parentPhone: parentPhoneController.text,
//                                       studentPhone: studentPhoneController.text,
//                                       email: emailController.text,
//                                       oldPassword: oldPasswordController.text,
//                                     ));
//                                   },
//                                   text: "تعديل"),
//                               TextButton(
//                                 onPressed: () {
//                                   bloc.add(NavigationToChangePassScreenEvent(
//                                       context: context));
//                                 },
//                                 child: const Text("هل تريد تغير كلمة المرور ؟"),
//                               )
//                             ]),
//                       ),
//                     ),
//                   ),
//                 )
//               : const Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
