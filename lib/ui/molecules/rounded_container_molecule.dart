import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class RoundedContainerMolecule extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;

  RoundedContainerMolecule({this.onTap, this.child, this.borderRadius = 20, this.margin = const EdgeInsets.all(10), this.padding = const EdgeInsets.all(5), this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.red, width: 5),
            color: CustomColors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(this.borderRadius),
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
