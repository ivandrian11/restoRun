import 'package:flutter/material.dart';
import '../common/themes.dart';
import '../widget/reusable_button.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Explore\nRestaurant  Around You',
                  style: headerStyle.copyWith(fontSize: 24),
                ),
                Image.asset(
                  'assets/img/boarding_illustration.png',
                  height: 250,
                ),
                ReusableButton(
                  color: const Color(0xff486D87),
                  height: 56,
                  width: double.infinity,
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/home'),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
