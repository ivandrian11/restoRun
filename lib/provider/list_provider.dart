import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/api/api_service.dart';

class ListProvider extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  ListProvider() {
    _fetchAllRestaurant();
  }

  Future<void> _fetchAllRestaurant() async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final restaurant = await ApiService.getAllData(Client());
      _apiResponse = ApiResponse.completed(restaurant.restaurants);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
