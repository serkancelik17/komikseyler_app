import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komix/ui/molecules/center_text_molecule.dart';

void main() {
  testWidgets("must be contain xxx", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: CenterTextMolecule(
      child: Text("xxx"),
    )));
    await tester.pump();
    expect(find.text("xxx"), findsOneWidget);
  });
}
