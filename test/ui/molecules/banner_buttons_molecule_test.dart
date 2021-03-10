import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/ui/molecules/banner_buttons_molecule.dart';
import 'package:komix/ui/molecules/button_with_icon_molecule.dart';
import 'package:mockito/mockito.dart';

class MockAdManager extends Mock implements AdManager {}

class MockAdmobReward extends Mock implements AdmobReward {}

void main() {
  AdManager mockAdManager = MockAdManager();
  AdmobReward mockAdmobReward = MockAdmobReward();
  testWidgets("BannerButtonsMolecule must be contain 2 ButtonWithIconMolecule", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BannerButtonsMolecule(mockAdManager, mockAdmobReward)));
    await tester.pump();
    expect(find.byType(ButtonWithIconMolecule), findsNWidgets(2));
  });

  testWidgets("bannerlerden ilkine tıklayınca aksiyon vermedi", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BannerButtonsMolecule(mockAdManager, mockAdmobReward)));
    await tester.pump();
    await tester.tap(find.text("Reklamları Kaldır"));
    await tester.pumpAndSettle();
//TODO expect eklenecek
    //expect(find.);
  });
}
