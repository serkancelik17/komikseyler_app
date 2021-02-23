import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';

class BannerMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainerMolecule(
      borderRadius: 5,
      child: BannerAtom(),
    );
  }
}
