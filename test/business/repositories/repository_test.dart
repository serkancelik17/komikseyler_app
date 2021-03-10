import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/models/category.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/models/response/simple_paginate_response.dart';
import 'package:komix/business/providers/api_provider.dart';
import 'package:komix/business/repositories/repository.dart';
import 'package:mockito/mockito.dart';

class MockDevice extends Mock implements Device {}

class MockResponse extends Mock implements Response {}

class MockApiProvider extends Mock implements ApiProvider {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group("Repository Class Should", () {
    final mockModel = MockDevice();
    final mockApiProvider = MockApiProvider();
    final mockResponse = MockResponse();
    final repository = Repository(
      apiProvider: mockApiProvider,
      response: mockResponse,
    );

    test('update() RETURN bool', () async {
      when(mockModel.getEndPoint()).thenAnswer((_) => "/devices/1");
      when(mockApiProvider.patch(any, any)).thenAnswer((_) async => '{"success":true}');
      expect(await repository.update(model: mockModel), isA<bool>());
    });

    group("where()", () {
      when(mockModel.getEndPoint()).thenAnswer((_) => "/devices");

      test('is RETURN List<Model>', () async {
        when(mockApiProvider.get(any)).thenAnswer((_) async => '{"success":true,"data":[],"message":null}');

        var actual = await repository.where(model: mockModel, parameters: {}, paginateType: PaginateType.none);

        expect(actual, isA<List<Model>>());
      });
      test('IF paginateType is PaginateType.none this.response is Response', () async {
        when(mockApiProvider.get(any)).thenAnswer((_) async => '{"success":true,"data":[],"message":null}');

        await repository.where(model: mockModel, parameters: {}, paginateType: PaginateType.none);

        expect(repository.response, isA<Response>());
      });
      test('IF paginateType is PaginateType.simple this.response is SimplePaginateResponse', () async {
        when(mockApiProvider.get(any)).thenAnswer((_) async => '{"success":true,"data":{"data":[{}]},"message":null}');

        await repository.where(model: mockModel, parameters: {}, paginateType: PaginateType.simple);

        expect(repository.response, isA<SimplePaginateResponse>());
      });
/*      test('IF paginateType is paginateType.paginate response  is PaginateResponse', () async {
        when(mockApiProvider.get(any)).thenAnswer((_) async => '{"success":true,"data":{"data":[{}]},"message":null}');

        await repository.where(model: mockModel, parameters: {}, paginateType: PaginateType.paginate);

        expect(repository.response, isA<PaginateResponse>());
      });*/

      test('WHEN response.success = false throw Exception', () async {
        when(mockApiProvider.get(any)).thenAnswer((_) async => '{"success":false,"data":{"data":[{}]},"message":null}');
        try {
          var actual = await repository.where(
              model: mockModel,
              parameters: {
                'id': 1,
                'filter': {'name': 'name'}
              },
              paginateType: PaginateType.paginate);
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    group("store()", () {
      test('WHEN response.success = true RETURN Model', () async {
        when(mockApiProvider.post(any, any)).thenAnswer((_) async => '{"success":true,"data":[{"id":1}],"message":null}');
        var actual = await repository.store(model: Category());
        expect(actual, isA<Model>());
      });

      test('WHEN response.success = false RETURN null', () async {
        when(mockApiProvider.post(any, any)).thenAnswer((_) async => '{"success":false,"data":null,"message":"error message"}');
        var actual = await repository.store(model: mockModel);
        expect(actual, null);
      });
    });

    test('destroy() must be  RETURN true', () async {
      when(mockApiProvider.delete(any)).thenAnswer((_) async => '{"success":true,"data":[],"message":null}');
      var actual = await repository.destroy(model: mockModel);
      expect(actual, true);
    });
  });
}
