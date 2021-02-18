import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class RoundedContainerMolecule extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  RoundedContainerMolecule({this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.red, width: 5),
            color: CustomColors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.darkGrey,
                blurRadius: 5,
                offset: Offset(5, 5), // Shadow position
              ),
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(-5, -5), // Shadow position
              ),
            ]),
        child: child,
      ),
      onTap: onTap,
    );
  }
}
