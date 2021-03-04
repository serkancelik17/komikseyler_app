import 'package:flutter/material.dart';
import 'package:komix/ui/templates/ErrorTemplate.dart';

class ErrorPage extends StatelessWidget {
  final Exception exception;

  //Error constructor
  ErrorPage({this.exception});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ErrorTemplate(title: Text("Komix"), exception: exception),
    );
  }
}
