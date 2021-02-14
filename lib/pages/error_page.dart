import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/util/settings.dart';

class ErrorPage extends StatefulWidget {
  Exception error;

  ErrorPage({@required this.error});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Settings.buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.error.toString()),
            RaisedButton(
              onPressed: () => Navigator.pop(context, '/'),
              child: Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}
