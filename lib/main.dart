import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/db/database_helper.dart';
import 'package:restorun/data/preferences/preferences_helper.dart';
import 'package:restorun/provider/database_provider.dart';
import 'package:restorun/provider/detail_provider.dart';
import 'package:restorun/provider/list_provider.dart';
import 'package:restorun/provider/preferences_provider.dart';
import 'package:restorun/provider/scheduling_provider.dart';
import 'package:restorun/provider/search_provider.dart';
import 'package:restorun/utils/background_service.dart';
import 'package:restorun/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/themes.dart';
import 'routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Restorun',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            elevation: 0,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryColor,
            selectionColor: primaryColor.withOpacity(.5),
            selectionHandleColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
