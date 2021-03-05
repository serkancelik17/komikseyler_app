import 'package:flutter/material.dart';
import 'package:komix/ui/templates/error_template.dart';

class ErrorPage extends StatelessWidget {
  final dynamic exception;

  //Error constructor
  ErrorPage({this.exception});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ErrorTemplate(title: Text("Komix"), exception: exception),
    );
  }
}
