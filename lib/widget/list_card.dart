import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/common/themes.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/widget/star_icon.dart';

class ListCard extends StatelessWidget {
  final Restaurants restaurant;

  const ListCard(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.intentWithData('/detail', restaurant),
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name!, style: subheadStyle),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/location_icon.svg',
                            color: greyColor,
                            width: iconSize2,
                          ),
                          SizedBox(width: 5),
                          Text(
                            restaurant.city!,
                            style: subhead2Style,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(children: ratingToStar(restaurant.rating)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
