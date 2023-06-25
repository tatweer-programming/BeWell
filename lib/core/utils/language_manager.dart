import 'package:BeWell/core/utils/color_manager.dart';
import 'package:BeWell/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LanguageManager{
  static bool isTextArabic(String text) {
    for (int i = 0; i < text.length; i++) {
      final charCode = text.codeUnitAt(i);
      if (charCode >= 0x0600 && charCode <= 0x06FF) {
        return true;
      }
      if (charCode >= 0x0041 && charCode <= 0x007A) {
        return false;
      }
    }

    return false;
  }
  static RichText formatText(String text) {
    final RegExp boldPattern = RegExp(r'#(.*?)#');
    List<TextSpan> textSpans = [];
    var matches = boldPattern.allMatches(text);
    int lastIndex = 0;

    for (Match match in matches) {
      final String normalText = text.substring(lastIndex, match.start);
      final String boldText = text.substring(match.start + 1, match.end - 1);

      if (normalText.isNotEmpty) {
        final normalSpan = TextSpan(
          text: normalText,
          style: TextStyle(fontWeight: FontWeightManager.regular,color: ColorManager.black,fontSize: FontSizeManager.s17.sp),
        );
        textSpans.add(normalSpan);
      }
      final boldSpan = TextSpan(
        text: boldText,
        style: TextStyle(fontWeight: FontWeightManager.bold,color: ColorManager.black,fontSize: FontSizeManager.s17.sp),
      );
      textSpans.add(boldSpan);
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      final normalSpan = TextSpan(
        text: text.substring(lastIndex),
        style: TextStyle(fontWeight: FontWeightManager.regular,color: ColorManager.black,fontSize: FontSizeManager.s17.sp),
      );
      textSpans.add(normalSpan);
    }
    return RichText(
      textDirection: LanguageManager.isTextArabic(text)? TextDirection.rtl : TextDirection.ltr,
      text: TextSpan(children: textSpans),
    );
  }
}