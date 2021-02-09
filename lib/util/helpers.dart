import 'package:flutter/material.dart';

import '../main.dart';

class Helpers {
  static void showSnackBar({@required BuildContext context, @required String text, @required Color backgroundColor}) {
    SnackBar _snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
      duration: Duration(milliseconds: 500),
    );
    mainScaffoldMessengerKey.currentState.showSnackBar(_snackBar);
  }
}
