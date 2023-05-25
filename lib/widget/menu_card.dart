import 'package:flutter/material.dart';
import '../common/themes.dart';

class MenuCard extends StatelessWidget {
  final bool isFood;
  final String name;

  const MenuCard({super.key, this.isFood = true, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(isFood ? 'assets/img/food.png' : 'assets/img/drink.png'),
          Flexible(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: headerStyle.copyWith(
                fontSize: 10,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
