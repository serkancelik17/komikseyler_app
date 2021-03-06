import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/providers/api_provider.dart';
import 'package:komix/business/repositories/repository.dart';
import 'package:mockito/mockito.dart';

class MockDevice extends Mock implements Device {}

class MockResponse extends Mock implements Response {}

class MockApiProvider extends Mock implements ApiProvider {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final endPoint = '/devices/xxx';
  final mockDevice = MockDevice();
  final mockApiProvider = MockApiProvider();
  final mockResponse = MockResponse();
  final repository =
      Repository(apiProvider: mockApiProvider, response: mockResponse);
  //Map<String, dynamic> jsonData = {'device_uuid': 'xxx'};
  //final _response = Response(success: true, metaData: GetMetaData(data: [jsonData]), message: "");

  when(mockDevice.uniqueId).thenReturn(1);
  when(mockDevice.getEndPoint()).thenAnswer((_) => endPoint);

/*  test('store response success ise model döndürmeli', () async {
    when(mockApiProvider.post(any, any)).thenAnswer((_) async => jsonEncode(_response.toJson()));

    expect(await repository.store(model: mockDevice), isA<Model>());
  });*/

/*
  test('store response false ise null model döndürmeli', () {
    final repository = Repository(apiProvider: mockApiProvider);

    when(mockApiProvider.post(endPoint, '{"device_uuid": "xxx"}')).thenAnswer((_) async => '{"success":"false"}');
    expect(repository.store(model: Device()), isA<Model>());
  });
*/

  test('update bool döndürmeli', () async {
    when(mockApiProvider.patch(any, any))
        .thenAnswer((_) async => '{"success":true}');
    expect(await repository.update(model: mockDevice), isA<bool>());
  });

  test('where model döndürmeli', () {});
  test('where paginateType is none response response olmalı', () {});
  test('where paginateType is simple response SimplePaginateResponse olmalı',
      () {});
  test(
      'where paginateType is paginate response PaginateResponse olmalı', () {});
  test('where store response false ise null model döndürmeli', () {});
  test('where _response success false ise exception firlatmali', () {});
}
