import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.primaryGrey,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      brightness: Brightness.dark,
    ));

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.primaryGrey,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      brightness: Brightness.light,
    ));
