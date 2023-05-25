import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/common/themes.dart';
import 'package:restorun/widget/star_icon.dart';

class RecommendedCard extends StatelessWidget {
  final Restaurants restaurant;

  const RecommendedCard(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.intentWithData('/detail', restaurant),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 228,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: cardShadow,
          image: DecorationImage(
            image: NetworkImage(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: ratingToStar(restaurant.rating)),
              Text(
                restaurant.name!,
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icon/location_icon.svg',
                    width: iconSize2,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    restaurant.city!,
                    style: subhead2Style.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
