import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komix/ui/molecules/button_with_icon_molecule.dart';

void main() {
  testWidgets("must be contain ElevatedButton", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ButtonWithIconMolecule(
      icon: Text("x"),
      label: Text("y"),
      onTap: () {},
    )));
    await tester.pump();
    expect(find.text("y"), findsOneWidget);
  });
}
