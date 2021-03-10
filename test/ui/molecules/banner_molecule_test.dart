import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komix/ui/atoms/banner_atom.dart';
import 'package:komix/ui/molecules/banner_molecule.dart';

void main() {
  testWidgets("BannerButtonsMolecule must be contain 2 ButtonWithIconMolecule", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BannerMolecule()));
    await tester.pump();
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(BannerAtom), findsOneWidget);
  });
}
