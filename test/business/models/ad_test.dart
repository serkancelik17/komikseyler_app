import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/ad.dart';

void main() {
  Ad ad = Ad();

  test('ad.get must be return ""', () {
    expect(ad.path, "");
  });
  test('ad.id must be return 0', () {
    expect(ad.id, 0);
  });
  test('ad.fromJson must be throw UnimplementedError', () {
    try {
      ad.fromJson({});
    } catch (e) {
      expect(e, isA<UnimplementedError>());
    }
  });
  test('ad.toJson must be throw UnimplementedError', () {
    try {
      ad.toJson();
    } catch (e) {
      expect(e, isA<UnimplementedError>());
    }
  });

  test('ad.toRawJson must be throw UnimplementedError', () {
    try {
      ad.toRawJson();
    } catch (e) {
      expect(e, isA<UnimplementedError>());
    }
  });
}
