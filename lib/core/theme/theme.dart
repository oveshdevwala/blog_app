import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: myOutlineInpBorder(),
        border: myOutlineInpBorder(),
        
        focusedErrorBorder: myOutlineInpBorder(
          color: AppPallete.gradient2),
        errorBorder: myOutlineInpBorder(color: AppPallete.errorColor),
        focusedBorder: myOutlineInpBorder(color: AppPallete.gradient2),
      ));
}

myOutlineInpBorder({Color color = AppPallete.borderColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: color, width: 2));
