import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle fontQuicksand_ExtraBold(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w800, fontSize: fontSize, color: color, height: lineHeight);
}

TextStyle fontQuicksand_Bold(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w700, fontSize: fontSize, color: color, height: lineHeight);
}

TextStyle fontQuicksand_Semibold(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: fontSize, color: color, height: lineHeight);
}

TextStyle fontQuicksand_Medium(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w500, fontSize: fontSize, color: color, height: lineHeight);
}

TextStyle fontQuicksand_Regular(double fontSize, {Color color = textColor, double lineHeight = 1.0, TextDecoration decoration = TextDecoration.none}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
}

 TextStyle fontQuicksand_Light(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w300, fontSize: fontSize, color: color, height: lineHeight);
}

TextStyle fontQuicksand_Extralight(double fontSize, {Color color = textColor, double lineHeight = 1.0}) {
  return GoogleFonts.quicksand(fontWeight: FontWeight.w200, fontSize: fontSize, color: color, height: lineHeight);
}
