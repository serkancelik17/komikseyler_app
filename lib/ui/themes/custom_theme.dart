import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: CustomColors.grey,
        scaffoldBackgroundColor: CustomColors.grey,
        fontFamily: 'VarelaRound', //3
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.purple,
        ));
  }
}
