// lib/theme.dart  — requiere forui ^0.22.3
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

FThemeData kodearTheme() {
  final base = FThemes.zinc.dark.touch;

  final colors = base.colors.copyWith(
    primary: const Color(0xFF00E5C8), // cyan Kodear
    primaryForeground: const Color(0xFF06231F), // texto/ícono sobre el cyan
  );

  return FThemeData(
    colors: colors,
    // En 0.22.3 FTypography.inherit SÍ acepta fontFamily (por eso te fallaba antes).
    typography: FTypography.inherit(
      colors: colors,
      touch: true,
      fontFamily: GoogleFonts.outfit().fontFamily!,
    ),
    touch: true,
  );
}
