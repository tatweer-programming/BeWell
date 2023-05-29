// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/utils/color_manager.dart';
// import '../bloc/auth_bloc.dart';
// import '../components/components.dart';
//
// class ChangePassScreen extends StatelessWidget {
//   const ChangePassScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var passwordController = TextEditingController();
//     var oldPasswordController = TextEditingController();
//     var confirmPasswordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     var bloc = AuthBloc.get(context);
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.white10,
//               iconTheme: const IconThemeData(color: Colors.black),
//             ),
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0.sp),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'تغير كلمة المرور ',
//                             style: TextStyle(
//                                 fontSize: 20.sp, fontWeight: FontWeight.w900),
//                           ),
//                           SizedBox(
//                             height: 20.sp,
//                           ),
//                           defaultFormField(
//                             label: 'كلمة المرور',
//                             prefix: Icons.lock_outline,
//                             suffix: IconButton(
//                                 onPressed: () {
//                                   bloc.add(const OldChangeVisibilityEvent());
//                                 },
//                                 icon: Icon(bloc.oldSuffix,
//                                 )),
//                             type: bloc.oldType,
//                             obscureText: bloc.oldVisibility,
//                             controller: oldPasswordController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'من فضلك اكتب كلمة المرور ';
//                               }
//                               if (passwordController.text ==
//                                   oldPasswordController.text) {
//                                 return 'كلمة المرور القديمة هي هي الجديدة ';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 2.5.h,
//                           ),
//                           defaultFormField(
//                             label: 'كلمة المرور الجديده',
//                             prefix: Icons.lock_outline,
//                             suffix: IconButton(
//                                 onPressed: () {
//                                   bloc.add(const ChangeVisibilityEvent());
//                                 },
//                                 icon: Icon(bloc.newSuffix)),
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
//                           SizedBox(
//                             height: 2.5.h,
//                           ),
//                           defaultFormField(
//                             label: 'تأكيد كلمة المرور الجديده',
//                             prefix: Icons.lock_outline,
//                             obscureText: true,
//                             controller: confirmPasswordController,
//                             validator: (value) {
//                               if (value!.isEmpty ||
//                                   passwordController.text !=
//                                       confirmPasswordController.text) {
//                                 return 'من فضلك تأكد من كتابة كلمة المرور تاني';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 2.5.h,
//                           ),
//                           defaultButton(
//                               onPressed: (){
//                                 if (formKey.currentState!.validate()) {
//                                   bloc.add(ChangePassEvent(
//                                       context: context,
//                                       newPassword: passwordController.text,
//                                       oldPassword: oldPasswordController.text));
//                                 }
//                               },
//                               text: "تغير"
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }
