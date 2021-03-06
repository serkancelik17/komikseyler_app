import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/business/models/action.dart' as Local;
import 'package:komix/ui/themes/custom_colors.dart';

void main() {
  Local.Action action = Local.Action(id: 1, name: "like", title: "Beğen");

  test("getIcon() must be return IconData", () {
    var actual = action.getIcon();
    expect(actual, FontAwesomeIcons.solidHeart);
  });

  test("getColor() must be return CustomColors", () {
    var actual = action.getColor();
    expect(actual, CustomColors.lightRed);
  });
}
