import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: GoogleFonts.poppins(fontSize: 10).fontFamily,
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
    textTheme: TextTheme(
        displayMedium: GoogleFonts.poppins(fontSize: 14),
        bodyMedium: GoogleFonts.poppins(fontSize: 14),
        bodyLarge: GoogleFonts.poppins(fontSize: 14)),
    fontFamily: GoogleFonts.poppins(fontSize: 14).fontFamily,
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
