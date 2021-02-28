import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';

class BannerMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          BannerAtom(),
        ],
      ),
    );
  }
}
