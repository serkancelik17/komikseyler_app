import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/ui/atoms/banner_atom.dart';
import 'package:komix/ui/atoms/button_atom.dart';
import 'package:komix/ui/atoms/center_atom.dart';
import 'package:komix/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komix/ui/atoms/column_atom.dart';
import 'package:komix/ui/atoms/fa_icon_atom.dart';
import 'package:komix/ui/atoms/indicatior_atom.dart';
import 'package:komix/ui/atoms/sized_box_atom.dart';
import 'package:komix/ui/atoms/text_atom.dart';

void main() {
  testWidgets('bannerAtom should be AdmobBanner', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BannerAtom()));
    await tester.pump();
    expect(find.byType(AdmobBanner), findsOneWidget);
  });

  testWidgets('buttonAtom should be ElevatedButton', (WidgetTester tester) async {
    Widget textWidget = Text("x");
    await tester.pumpWidget(MaterialApp(
        home: ButtonAtom(
      child: textWidget,
    )));
    await tester.pump();
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('buttonAtom should be contain Text Widget', (WidgetTester tester) async {
    Widget textWidget = Text("x");
    await tester.pumpWidget(MaterialApp(
        home: ButtonAtom(
      child: textWidget,
    )));
    await tester.pump();
    expect(find.byWidget(textWidget), findsOneWidget);
  });

  testWidgets('centerAtom should be Center', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CenterAtom()));
    await tester.pump();
    expect(find.byType(Center), findsOneWidget);
  });

  testWidgets('centerAtom should be contain Text Widget', (WidgetTester tester) async {
    Widget textWidget = Text("x");
    await tester.pumpWidget(MaterialApp(
        home: CenterAtom(
      child: textWidget,
    )));
    await tester.pump();
    expect(find.byWidget(textWidget), findsOneWidget);
  });

  testWidgets('circularProgressIndicatorAtom should be CircularProgressIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CircularProgressIndicatorAtom()));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('columnAtom should be Column', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ColumnAtom(children: [Text("x")])));
    await tester.pump();
    expect(find.byType(Column), findsOneWidget);
  });

  testWidgets('columnAtom should be contain Text Widget', (WidgetTester tester) async {
    Widget textWidget = Text("x");
    await tester.pumpWidget(MaterialApp(
        home: ColumnAtom(
      children: [textWidget],
    )));
    await tester.pump();
    expect(find.byWidget(textWidget), findsOneWidget);
  });

  testWidgets('faIconAtom should be FaIcon', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FaIconAtom(icon: FontAwesomeIcons.store)));
    await tester.pump();
    expect(find.byType(FaIcon), findsOneWidget);
  });

/*  testWidgets('imageNetworkAtom should be Image', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ImageNetworkAtom(url: "https://via.placeholder.com/150")));
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
  });*/
  testWidgets('indicatorAtom should be Container', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IndicatorAtom()));
    await tester.pump();
    expect(find.byType(Container), findsOneWidget);
  });

/*  testWidgets('linearIndicatorAtom should be LinearPercentIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LinearIndicatorAtom()));
    await tester.pump();
    expect(find.byType(LinearPercentIndicator), findsOneWidget);
  });*/

  testWidgets('SizedBoxAtom should be SizedBox', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SizedBoxAtom()));
    await tester.pump();
    expect(find.byType(SizedBox), findsOneWidget);
  });
  testWidgets('TextAtom should be Text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TextAtom(text: "x")));
    await tester.pump();
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('TextAtom should be contain x', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TextAtom(text: "x")));
    await tester.pump();
    expect(find.text("x"), findsOneWidget);
  });
}
