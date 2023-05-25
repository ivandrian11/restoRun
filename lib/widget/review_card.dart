import 'package:flutter/material.dart';
import '../common/themes.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  const ReviewCard({
    super.key,
    required this.date,
    required this.name,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/img/ava.png',
            height: 48,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: headerStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 16),
                Text(
                  review,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
