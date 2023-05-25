import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const firstTime = 'FIRST_TIME';

  Future<bool> get isFirstTime async {
    final prefs = await sharedPreferences;
    return prefs.getBool(firstTime) ?? true;
  }

  void setFirstTime(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(firstTime, value);
  }

  static const dailyNotif = 'DAILY_NOTIF';

  Future<bool> get isDailyNotifActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNotif) ?? false;
  }

  void setDailyNotif(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNotif, value);
  }
}
