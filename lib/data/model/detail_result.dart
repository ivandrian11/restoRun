class DetailResult {
  DetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });
  late final bool error;
  late final String message;
  late final Restaurant restaurant;

  DetailResult.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant = Restaurant.fromJson(json['restaurant']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['restaurant'] = restaurant.toJson();
    return data;
  }
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String city;
  late final String address;
  late final String pictureId;
  late final List<Categories> categories;
  late final Menus menus;
  late final double rating;
  late final List<CustomerReviews> customerReviews;

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = json['pictureId'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    menus = Menus.fromJson(json['menus']);
    rating = json['rating'].toDouble();
    customerReviews = List.from(json['customerReviews'])
        .map((e) => CustomerReviews.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['city'] = city;
    data['address'] = address;
    data['pictureId'] = pictureId;
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['menus'] = menus.toJson();
    data['rating'] = rating;
    data['customerReviews'] = customerReviews.map((e) => e.toJson()).toList();
    return data;
  }
}

class Categories {
  Categories({
    required this.name,
  });
  late final String name;

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });
  late final List<Foods> foods;
  late final List<Drinks> drinks;

  Menus.fromJson(Map<String, dynamic> json) {
    foods = List.from(json['foods']).map((e) => Foods.fromJson(e)).toList();
    drinks = List.from(json['drinks']).map((e) => Drinks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foods'] = foods.map((e) => e.toJson()).toList();
    data['drinks'] = drinks.map((e) => e.toJson()).toList();
    return data;
  }
}

class Foods {
  Foods({
    required this.name,
  });
  late final String name;

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Drinks {
  Drinks({
    required this.name,
  });
  late final String name;

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class CustomerReviews {
  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });
  late final String name;
  late final String review;
  late final String date;

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['review'] = review;
    data['date'] = date;
    return data;
  }
}
