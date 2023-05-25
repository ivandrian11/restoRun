import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restorun/common/navigation.dart';
import '../common/themes.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.intent('/search'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 48,
        width: double.infinity,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icon/search_icon.svg',
              height: iconSize,
            ),
            const SizedBox(width: 16),
            Text(
              'Search Restaurant',
              style: subhead2Style.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
