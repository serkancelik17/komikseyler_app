import 'package:flutter/material.dart';

class DialogMolecule {
  DialogMolecule.showAlertDialog(BuildContext context, VoidCallback onPress) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Teşekkürler"),
      onPressed: onPress,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Tebrikler"),
      content: Text("30 dakika reklam görmeyeceksiniz."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
