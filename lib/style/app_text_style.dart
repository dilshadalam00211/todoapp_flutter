import 'package:flutter/material.dart';
import 'package:flutter_todo/style/app_colors.dart';

class AppTextStyle {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle textFieldFont = TextStyle(
    color: AppColors.textFieldFontColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle textFieldLabelStyle = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
