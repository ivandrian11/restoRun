import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restorun/data/api/api_service.dart';
import 'package:restorun/data/model/list_result.dart';
import 'json_parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant api', () {
    final restaurantTest = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
      ]
    };

    test('must contain a list of restaurant when api successful', () async {
      final client = MockClient();

      when(
        client.get(
          Uri.parse("${ApiService.baseUrl}/list"),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(restaurantTest), 200));

      expect(await ApiService.getAllData(client), isA<ListResult>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(
        client.get(
          Uri.parse("${ApiService.baseUrl}/list"),
        ),
      ).thenAnswer((_) async =>
          http.Response('Failed to load list of restaurants', 404));

      expect(ApiService.getAllData(client), throwsException);
    });
  });
}
