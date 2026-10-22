import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class AppPalette {
  final double darkness;
  bool get isDark => darkness >= 0.5;
  final Color bgMain, bgHeader, bgCard, bgCardAlt, bgInput, border;
  final Color textMain, textSub, accent, accentLight, popBg, popHeader;
  final Color shadow, cropLine;
  final List<Color> blobs;

  const AppPalette({
    required this.darkness,
    required this.bgMain,
    required this.bgHeader,
    required this.bgCard,
    required this.bgCardAlt,
    required this.bgInput,
    required this.border,
    required this.textMain,
    required this.textSub,
    required this.accent,
    required this.accentLight,
    required this.popBg,
    required this.popHeader,
    required this.shadow,
    required this.cropLine,
    required this.blobs,
  });

  static const dark = AppPalette(
    darkness: 1,
    bgMain: Color(0xFF0F1115),
    bgHeader: Color(0xFF12141A),
    bgCard: Color(0xFF141823),
    bgCardAlt: Color(0xFF1C2230),
    bgInput: Color(0xFF1A2030),
    border: Color(0xFF2D3344),
    textMain: Colors.white,
    textSub: Color(0xFFAAAAAA),
    accent: Color(0xFF007BFF),
    accentLight: Color(0xFF6EA8FF),
    popBg: Color(0xFF252830),
    popHeader: Color(0xFF1A1D24),
    shadow: Color(0x99000000),
    cropLine: Color(0xFFA0D7FE),
    blobs: [Color(0xFF007BFF), Color(0xFF8E44AD), Color(0xFF00CEC9), Color(0xFFE67E22)],
  );

  static const light = AppPalette(
    darkness: 0,
    bgMain: Color(0xFFF0F6FF),
    bgHeader: Color(0xFFE1EFFE),
    bgCard: Color(0xFFE3E3E3),
    bgCardAlt: Color(0xFFF4F9FF),
    bgInput: Color(0xFFE8F2FE),
    border: Color(0xFFB9D7FB),
    textMain: Color(0xFF0F172A),
    textSub: Color(0xFF475569),
    accent: Color(0xFF007BFF),
    accentLight: Color(0xFF38BDF8),
    popBg: Color(0xFFE3E3E3),
    popHeader: Color(0xFFE1EFFE),
    shadow: Color(0x26007BFF),
    cropLine: Color(0xFF007BFF),
    blobs: [Color(0xFF38BDF8), Color(0xFFB39DFF), Color(0xFF7FE7DC), Color(0xFFFFC38A)],
  );
}

class ThemeController extends ChangeNotifier {
  final SharedPreferences prefs;
  ThemeController(this.prefs);
  bool get isDark => prefs.getBool('isDark') ?? true;
  void toggle() {
    prefs.setBool('isDark', !isDark);
    notifyListeners();
  }
}

class AppThemeScope extends InheritedWidget {
  final ThemeController controller;
  const AppThemeScope({super.key, required this.controller, required super.child});
  static AppThemeScope of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppThemeScope>()!;
  @override
  bool updateShouldNotify(AppThemeScope old) => true;
}

ThemeData buildTheme(AppPalette palette) => ThemeData(
  useMaterial3: true,
  brightness: palette.isDark ? Brightness.dark : Brightness.light,
  scaffoldBackgroundColor: palette.bgMain,
  colorScheme: ColorScheme.fromSeed(
    seedColor: palette.accent,
    brightness: palette.isDark ? Brightness.dark : Brightness.light,
  ),
);
