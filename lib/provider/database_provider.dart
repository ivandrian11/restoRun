import 'package:flutter/material.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/db/database_helper.dart';
import 'package:restorun/data/model/list_result.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    getFavorite();
  }

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  void getFavorite() async {
    _apiResponse = ApiResponse.loading('Fetching data');
    try {
      final restaurant = await databaseHelper.getFavorite();
      if (restaurant.isEmpty) {
        _apiResponse = ApiResponse.error("No Data");
      } else {
        _apiResponse = ApiResponse.completed(restaurant);
      }
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void addFavorite(Restaurants restaurants) async {
    try {
      await databaseHelper.insertFavorite(restaurants);
      getFavorite();
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorite();
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
