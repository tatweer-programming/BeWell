import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'values_manager.dart';
import 'font_manager.dart';
import 'color_manager.dart';
import 'styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData (
    appBarTheme: const AppBarTheme(
      foregroundColor: Color(0xFFfffafafb),
    ),
    applyElevationOverlayColor: false,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      alignedDropdown: false,
      colorScheme: ColorScheme(
        background: Color(0xFFff6882b8),
        brightness: Brightness.light,
        error: Color(0xFFffb00020),
        errorContainer: Color(0xFFffb00020),
        inversePrimary: Color(0xFFffffffff),
        inverseSurface: Color(0xFF000000),
        onBackground: Color(0xFF000000),
        onError: Color(0xFFffffffff),
        onErrorContainer: Color(0xFFffffffff),
        onInverseSurface: Color(0xFFffffffff),
        onPrimary: Color(0xFF000000),
        onPrimaryContainer: Color(0xFFffffffff),
        onSecondary: Color(0xFF000000),
        onSecondaryContainer: Color(0xFF000000),
        onSurface: Color(0xFF000000),
        onSurfaceVariant: Color(0xFF000000),
        onTertiary: Color(0xFF000000),
        onTertiaryContainer: Color(0xFF000000),
        outline: Color(0xFF000000),
        outlineVariant: Color(0xFF000000),
        primary: Color(0xFF274c9a),
        primaryContainer: Color(0xFF6200ee),
        secondary: Color(0xFF5db134),
        secondaryContainer: Color(0xFF03dac6),
        shadow: Color(0xFF000000),
        surface: Color(0xFFFFFFFF),
        surfaceTint: Color(0xFF6200ee),
        surfaceVariant: Color(0xFFFFFFFF),
        tertiary: Color(0xFF03dac6),
        tertiaryContainer: Color(0xFF03dac6),
      ),
      height: 36,

      minWidth: 88,
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          )
      ),
      textTheme: ButtonTextTheme.normal,
    ),
    canvasColor: const Color(0xFFfafafa),
    cardColor: const Color(0xFFFFFFFF),
    dialogBackgroundColor: const Color(0xFFFFFFFF),
    disabledColor: const Color(0xFF61000000),
    dividerColor: const Color(0xFF1f000000),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(/* ... */),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFFfffafafb),
    ),
    focusColor: const Color(0xFF1f000000),
    highlightColor: const Color(0xFF66bcbcbc),
    hintColor: const Color(0xFF99000000),
    hoverColor: const Color(0xFF0a000000),
    iconTheme: const IconThemeData(
      color: Color(0xFFfffafafb),
    ),
    indicatorColor: const Color(0xFF274c9a),
    inputDecorationTheme: const InputDecorationTheme(/* ... */),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    platform: TargetPlatform.windows,
    primaryColor: const Color(0xFF274c9a),
    primaryColorDark: const Color(0xFF1f3d7b),
    primaryColorLight: const Color(0xFF7d94c2),
    primaryIconTheme:  IconThemeData(
       color: ColorManager.white
    ),
    scaffoldBackgroundColor: const Color(0xFFfafafa),
    secondaryHeaderColor: const Color(0xFF889dc7),
    shadowColor: const Color(0xFF000000),
    splashColor: const Color(0xFF66c8c8c8),
    splashFactory: InkSplash.splashFactory,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(/* ... */),
    ),

    typography: Typography(/* ... */),
    unselectedWidgetColor: const Color(0xFF8a0a0a0a),
    useMaterial3: false,
    visualDensity: VisualDensity.compact,
  );
}
