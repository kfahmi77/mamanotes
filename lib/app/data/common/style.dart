import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color white = const Color(0xffffffff);
Color background = const Color(0xffffcdd7);
Color red = const Color(0xffFF597B);
Color grey = const Color(0xffD9D9D9);
Color black = const Color(0xFF000000);
Color cardDiary = const Color(0xffFFF6D4);
const Color lightBlackColor = Color(0xff595550);

TextStyle primaryStyle =
    GoogleFonts.lato(fontStyle: FontStyle.italic, fontSize: 20);
TextStyle whiteTextStyle = GoogleFonts.montserrat(color: white);
TextStyle redTextStyle = GoogleFonts.montserrat(color: red);
TextStyle robottoBlackTextStyle = GoogleFonts.roboto();
final TextStyle formTitleTextStyle = GoogleFonts.nunito(
  color: black,
  fontSize: 24,
  fontWeight: FontWeight.w900,
);
final TextStyle formDescriptionTextStyle = GoogleFonts.nunito(
  color: lightBlackColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

FontWeight light = FontWeight.w300;
FontWeight normal = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
