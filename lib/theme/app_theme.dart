import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static AppThemeScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppThemeScope>()!;

  @override
  bool updateShouldNotify(AppThemeScope old) => true;
}

ThemeData buildTheme(dynamic palette) => ThemeData.dark(useMaterial3: true);
