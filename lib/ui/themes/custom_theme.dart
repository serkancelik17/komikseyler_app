import 'package:flutter/material.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: CustomColors.grey,
        scaffoldBackgroundColor: CustomColors.grey,
        bottomAppBarColor: CustomColors.grey,
        fontFamily: 'VarelaRound', //3
        buttonTheme: ButtonThemeData(
          buttonColor: CustomColors.purple,
        ));
  }
}
