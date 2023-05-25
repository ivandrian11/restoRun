import 'package:flutter/material.dart';
import 'package:restorun/ui/favorite_page.dart';
import 'common/themes.dart';
import 'ui/boarding_page.dart';
import 'ui/splash_page.dart';
import 'ui/search_page.dart';
import 'ui/detail_page.dart';
import 'ui/home_page.dart';
import 'ui/list_page.dart';
import 'ui/profile_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(settings) {
    // jika ingin mengirim argument
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/boarding':
        return MaterialPageRoute(builder: (_) => BoardingPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/detail':
        return MaterialPageRoute(builder: (_) => DetailPage(args));
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case '/list':
        return MaterialPageRoute(builder: (_) => ListPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/favorite':
        return MaterialPageRoute(builder: (_) => FavoritePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error page', style: errorStyle),
        ),
      );
    });
  }
}
