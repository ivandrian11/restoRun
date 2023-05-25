import 'package:flutter/material.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/api/api_service.dart';
import 'package:restorun/data/model/list_result.dart';

class SearchProvider extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.completed(<Restaurants>[]);
  ApiResponse get response => _apiResponse;

  Future<void> fetchData(String query) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final restaurant = await ApiService.searchData(query);
      _apiResponse = ApiResponse.completed(restaurant.restaurants);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
