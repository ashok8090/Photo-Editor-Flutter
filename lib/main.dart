import 'package:flutter/material.dart';
import 'package:photo_merger_highlighter/screens/home_screen.dart';
import 'package:photo_merger_highlighter/state/app_state.dart';
import 'package:photo_merger_highlighter/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PhotoHighlighterApp());
}

class PhotoHighlighterApp extends StatelessWidget {
  const PhotoHighlighterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Photo Highlighter',
            theme: state.isDark ? AppTheme.dark : AppTheme.light,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
