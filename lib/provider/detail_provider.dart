import 'package:flutter/material.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/api/api_service.dart';

class DetailProvider extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  int _activedIndex = 0;
  int get index => _activedIndex;

  void changeIndex(int index) {
    _activedIndex = index;
    notifyListeners();
  }

  Future<void> fetchData(String id) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final restaurant = await ApiService.getDataById(id);
      _apiResponse = ApiResponse.completed(restaurant.restaurant);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
