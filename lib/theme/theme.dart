import 'package:flutter/material.dart';

const kBlue = Color(0xFF007ACC); // основной синий
const kOrange = Color(0xFFFF8C00); // акцент
const kText = Color(0xFF111111);
const kBg = Color(0xFFFFFFFF);

ThemeData appTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: kBg,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kBlue,
    primary: kBlue,
    secondary: kOrange,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: kText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF6F7FA),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide.none,
    ),
  ),
);
