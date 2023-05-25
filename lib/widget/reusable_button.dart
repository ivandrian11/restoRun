import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double height;
  final Color color;

  const ReusableButton({
    super.key,
    required this.child,
    required this.color,
    required this.height,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: color,
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: width ?? height,
        height: height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    );
  }
}
