import 'package:BeWell/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';


Widget defaultFormField(
    {required String label,
       IconData ? prefix,
      IconData? suffix,
      GlobalKey? key,
      String? validatorText,
      TextInputType ? type,
      void Function()? suffixFunction,
      bool obscureText = false,
      required TextEditingController controller, required String? Function(dynamic value) validator}) {
  return TextFormField(
    validator: validator,
    keyboardType: type,
    obscureText: obscureText,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.sp),
        borderSide: BorderSide(width: 1, color: ColorManager.black),),
      prefixIcon: Icon(prefix,),
      suffix: suffix != null
          ? InkWell(
        onTap: suffixFunction,
        child: Icon(suffix),
      )
          : const SizedBox(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: BorderSide(width: 1, color: ColorManager.black),),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: BorderSide(width: 1, color: ColorManager.black),
      ),
      labelText: label,
      labelStyle: TextStyle(color: ColorManager.black),
    ),
    style: TextStyle(color: ColorManager.primary),
  );
}


defaultToast ({required String msg , })
{

  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.primary, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );
}
errorToast ({required String msg ,}){
  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.error, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );
}
Widget progress({required String courseName,required String percent}) => Padding(
  padding: EdgeInsets.symmetric(
      vertical: 10.sp
  ),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(courseName,
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightManager.semiBold
        ),),
      Text("$percent%",
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightManager.semiBold
        ),),
    ],
  ),
);

