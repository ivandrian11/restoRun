import 'package:flutter/material.dart';
import 'package:restorun/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getFirstTimePreferences();
    _getDailyNotifPreferences();
  }

  bool _isDailyNotifActive = false;
  bool get isDailyNotifActive => _isDailyNotifActive;

  bool _isFirstTime = false;
  bool get isFirstTime => _isFirstTime;

  void _getDailyNotifPreferences() async {
    _isDailyNotifActive = await preferencesHelper.isDailyNotifActive;
    notifyListeners();
  }

  void enableDailyNotif(bool value) {
    preferencesHelper.setDailyNotif(value);
    _getDailyNotifPreferences();
  }

  void _getFirstTimePreferences() async {
    _isFirstTime = await preferencesHelper.isFirstTime;
    notifyListeners();
  }

  void changeFirstTime(bool value) {
    preferencesHelper.setFirstTime(value);
    _getFirstTimePreferences();
  }
}
