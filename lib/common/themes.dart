import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xffFFB838);
const Color secondaryColor = Color(0xffFEE5A5);
const Color blackColor = Color(0xff232323);
const Color greyColor = Color(0xffAAAAAA);
const Color iconColor = Color(0xff4A4A4A);

const TextStyle errorStyle = TextStyle(
  color: Colors.red,
  fontSize: 20,
);

const TextStyle headerStyle = TextStyle(
  color: blackColor,
  fontSize: 18,
  fontWeight: semiBold,
);

TextStyle subheadStyle = GoogleFonts.playfairDisplay(
  color: blackColor,
  fontSize: 18,
  fontWeight: bold,
);

const TextStyle subhead2Style = TextStyle(
  color: greyColor,
  fontSize: 12,
  fontWeight: medium,
);

TextStyle customAppbarStyle = GoogleFonts.playfairDisplay(
  color: blackColor,
  fontSize: 24,
  fontWeight: bold,
);

UnderlineInputBorder chooseColorBorder(Color color) => UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );

const FontWeight light = FontWeight.w300;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;

double margin = 24;
double iconSize = 24;
double iconSize2 = 20;

const List<BoxShadow> cardShadow = [
  BoxShadow(
    color: Colors.black26,
    blurRadius: 4,
    offset: Offset(0, 4),
  ),
];
