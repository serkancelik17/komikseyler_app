import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/providers/api_provider.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockEnv extends Mock implements Env {}

void main() {
  final mockHttpClient = MockHttpClient();
  final mockEnv = MockEnv();
  final apiProvider = ApiProvider(
      httpClient: mockHttpClient,
      env: mockEnv);
  final endPoint = '/devices/xxx';

  test('get fonksiyonu string getirmeli', () async {
    when(mockHttpClient.get(Uri.parse(Env.apiUrl + endPoint)))
        .thenAnswer((_) async => http.Response('{"status": true}', 200));
    expect(await apiProvider.get(endPoint), isA<String>());
  });
  test('get 200 den farkli ise dondugunde expection fırlatmalı', () async {
    when(mockHttpClient.get(Uri.parse(Env.apiUrl + endPoint)))
        .thenAnswer((_) async => http.Response('{"status": true}', 404));
    expect(() async => await apiProvider.get(endPoint), throwsException);
  });

  test('post string dondurmeli', () async {
    when(mockHttpClient.post(Uri.parse(Env.apiUrl + endPoint),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: '{}'))
        .thenAnswer((_) async => http.Response('{"status": true}', 200));
    expect(await apiProvider.post(endPoint, '{}'), isA<String>());
  });

  test('post 200 den farkli ise dondugunde expection fırlatmalı', () async {
    when(mockHttpClient.post(Uri.parse(Env.apiUrl + endPoint),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: '{}'))
        .thenAnswer((_) async => http.Response('{"status": true}', 404));
    expect(() async => await apiProvider.post(endPoint, '{}'), throwsException);
  });

  test('patch string döndürmeli', () async {
    when(mockHttpClient.patch(Uri.parse(Env.apiUrl + endPoint),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: '{}'))
        .thenAnswer((_) async => http.Response('{"status": true}', 200));
    expect(await apiProvider.patch(endPoint, '{}'), isA<String>());
  });

  test('patch 200 den farkli ise dondugunde expection fırlatmalı', () async {
    when(mockHttpClient.patch(Uri.parse(Env.apiUrl + endPoint),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: '{}'))
        .thenAnswer((_) async => http.Response('{"status": true}', 404));
    expect(
        () async => await apiProvider.patch(endPoint, '{}'), throwsException);
  });

  test('delete string döndürmeli', () async {
    when(mockHttpClient.delete(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response('{"status": true}', 200));
    expect(await apiProvider.delete(endPoint), isA<String>());
  });
  test('delete 200 den farkli ise dondugunde expection fırlatmalı', () async {
    when(mockHttpClient.delete(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('{"status": true}', 404));
    expect(() async => await apiProvider.delete(endPoint), throwsException);
  });
}
