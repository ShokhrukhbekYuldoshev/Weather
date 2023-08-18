import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0700FF);
const Color whiteColor = Color(0xFFFFFFFF);
const Color blackColor = Color(0xFF000000);
const Color errorColor = Color(0xFFE74C3C);
const Color strokeColor = Color(0xFFE4E6EC);
const Color shadowColor = Color(0xFFBD87FF);

// text
const Color textColor = Color(0xFF1B1918);
const Color headerTextColor = Color(0xFF2B2D33);
const Color greyTextColor = Color(0xFF8799A5);

LinearGradient get primaryDarkGradient => const LinearGradient(
      colors: [
        Color(0xFF0700FF),
        Color(0xFF000000),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

LinearGradient get primaryLightGradient => LinearGradient(
      colors: [
        const Color(0xFF0700FF).withOpacity(0.4392),
        const Color(0xFF000000),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
