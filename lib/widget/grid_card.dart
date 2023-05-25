import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/model/list_result.dart';
import '../common/themes.dart';

class GridCard extends StatelessWidget {
  final Restaurants restaurant;

  const GridCard(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.intentWithData('/detail', restaurant),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      restaurant.name!,
                      style: subheadStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Row(
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
