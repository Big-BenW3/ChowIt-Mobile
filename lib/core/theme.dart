import 'package:flutter/material.dart';

// Design tokens lifted from the Figma prototype: brand orange, warm
// surfaces, Manrope-style type scale, and generous corner radii. Every
// screen reads its colors and text styles from here, never hard-codes them.
abstract final class ChowColors {
  static const orange = Color(0xFFF16A2B);
  static const deep = Color(0xFFD9531E);
  static const peach = Color(0xFFFFF0E6);
  static const warm = Color(0xFFFFFCF9);
  static const ink = Color(0xFF25211F);
  static const body = Color(0xFF665F5B);
  static const muted = Color(0xFF817A75);
  static const faint = Color(0xFF9B938E);
  static const border = Color(0xFFEEE8E2);
  static const green = Color(0xFF25865A);
  static const greenSoft = Color(0xFFE8F5EE);
  static const yellow = Color(0xFFFFF1D5);
  static const gold = Color(0xFFF2A900);
  static const danger = Color(0xFFCF4545);
  static const dark = Color(0xFF292320);
  static const darkCard = Color(0xFF322820);
  static const demoBg = Color(0xFFFFF7DE);
  static const demoBorder = Color(0xFFF5E4AD);
  static const demoInk = Color(0xFFB48300);
}

abstract final class ChowRadii {
  static const sm = Radius.circular(10);
  static const md = Radius.circular(15);
  static const lg = Radius.circular(19);
  static const xl = Radius.circular(26);
  static const pill = Radius.circular(999);
}

ThemeData chowTheme() {
  final base = ThemeData(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: ChowColors.warm,
    colorScheme: base.colorScheme.copyWith(
      primary: ChowColors.orange,
      onPrimary: Colors.white,
      surface: ChowColors.warm,
      onSurface: ChowColors.ink,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 29,
        height: 1.13,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.1,
        color: ChowColors.ink,
      ),
      headlineSmall: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: ChowColors.ink,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: ChowColors.ink,
      ),
      titleMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: ChowColors.ink,
      ),
      bodyMedium: TextStyle(fontSize: 14, height: 1.55, color: ChowColors.body),
      bodySmall: TextStyle(fontSize: 12, color: ChowColors.muted),
    ),
  );
}
