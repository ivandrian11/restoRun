import 'package:flutter/material.dart';

class StarIcon extends StatelessWidget {
  final bool isActive;
  final double? size;

  const StarIcon({
    super.key,
    required this.isActive,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      isActive ? Icons.star : Icons.star_border_outlined,
      color: isActive ? const Color(0xffF1C644) : const Color(0xffD4D4D4),
      size: size ?? 16,
    );
  }
}

List<Widget> ratingToStar(double? rating) {
  List<Widget> stars = [];
  for (var i = 1; i <= 5; i++) {
    stars.add(StarIcon(isActive: i <= rating!));
  }
  return stars;
}
