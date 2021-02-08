import 'package:flutter/material.dart';

import '../main.dart';

class ShowSnackBar extends StatefulWidget {
  final String text;
  final Color backgroundColor;

  ShowSnackBar(this.text, this.backgroundColor);

  @override
  _ShowSnackBarState createState() => _ShowSnackBarState();
}

class _ShowSnackBarState extends State<ShowSnackBar> {
  @override
  Widget build(BuildContext context) {
    SnackBar _snackBar = SnackBar(
      content: Text(widget.text),
      backgroundColor: widget.backgroundColor,
      duration: Duration(milliseconds: 500),
    );
    mainScaffoldMessengerKey.currentState.showSnackBar(_snackBar);
  }
}
