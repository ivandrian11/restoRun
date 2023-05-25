import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/provider/preferences_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<PreferencesProvider>(context, listen: false);

    Timer(
      const Duration(seconds: 5),
      () {
        if (provider.isFirstTime) {
          Navigation.off('/boarding');
          provider.changeFirstTime(false);
        } else {
          Navigation.off('/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/img/logo.png',
          height: 120,
        ),
      ),
    );
  }
}
