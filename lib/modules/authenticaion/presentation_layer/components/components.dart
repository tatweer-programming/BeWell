
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
  return Container(


    child: TextFormField(
      validator: validator,
      keyboardType: type,
      obscureText: obscureText,
      controller: controller,
      cursorColor: ColorManager.black,
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
    ),
  );
}
Widget defaultButton ({required void Function()
onPressed , required String text , TextStyle ? style, Color ? color  }){
  return Container(
    decoration:  BoxDecoration(
      color: color ?? ColorManager.primary,

      borderRadius: BorderRadius.all(Radius.circular(10.sp))
    ),

      child: MaterialButton(onPressed: onPressed ,
        child: Text(text,style: style ?? TextStyle(fontWeight: FontWeightManager.bold, fontSize: 18 ,   color: ColorManager.white )),));
}
defaultToast ({required String msg , })
{

  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.primary, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );
}
errorToast ({required String msg ,}){
  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.error, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );
}

