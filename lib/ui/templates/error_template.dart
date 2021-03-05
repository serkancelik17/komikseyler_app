import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/ui/atoms/button_atom.dart';
import 'package:komix/ui/organisms/app_bar_organism.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class ErrorTemplate extends StatelessWidget {
  final Widget title;
  final dynamic exception;

  ErrorTemplate({@required this.title, this.exception});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: title ?? Text("{title}"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.exclamationCircle,
              color: CustomColors.lightRed,
              size: 70,
            ),
            Center(
                child: Column(
              children: [
                Text("Beklenmedik hata oluştu."),
                Text("Tekrar deneyiniz."),
                SizedBox(height: 10),
                Text(
                  "Hata kodu: " + exception.toString(),
                  style: TextStyle(
                    color: CustomColors.boldGrey,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 10),
                ButtonAtom(
                  child: Text("Tekrar Dene"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
