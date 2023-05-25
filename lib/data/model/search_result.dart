import 'package:restorun/data/model/list_result.dart';

class SearchResult {
  SearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });
  late final bool error;
  late final int founded;
  late final List<Restaurants> restaurants;

  SearchResult.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    founded = json['founded'];
    restaurants = List.from(json['restaurants'])
        .map((e) => Restaurants.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['founded'] = founded;
    data['restaurants'] = restaurants.map((e) => e.toJson()).toList();
    return data;
  }
}
