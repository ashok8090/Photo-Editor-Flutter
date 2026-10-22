import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'services/album_repository.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

/// Photo Merger & Highlighter — Flutter port of the single-file HTML app.
///
/// The first frame is drawn immediately (splash). Storage is opened afterwards,
/// with timeouts, so a slow / broken album can never leave a black screen.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    // Release builds otherwise show a blank grey/black box on a build error.
    ErrorWidget.builder = (d) => Material(
          color: const Color(0xFF0F1115),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('UI error:\n${d.exceptionAsString()}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ),
          ),
        );
  }
  runApp(const BootApp());
}

class _Boot {
  final ThemeController theme;
  final AppState state;
  _Boot(this.theme, this.state);
}

class BootApp extends StatefulWidget {
  const BootApp({super.key});

  @override
  State<BootApp> createState() => _BootAppState();
}

class _BootAppState extends State<BootApp> {
  late Future<_Boot> _boot = _start();

  Future<_Boot> _start() async {
    final prefs = await SharedPreferences.getInstance().timeout(const Duration(seconds: 10));
    final album = AlbumRepository();
    await album.init().timeout(const Duration(seconds: 20));
    // Old-format album data is moved over in the background, once.
    unawaited(Future<void>.delayed(const Duration(seconds: 3), () => album.migrateLegacy(prefs)));
    return _Boot(ThemeController(prefs), AppState(album));
  }

  void _retry() => setState(() => _boot = _start());

  Future<void> _reset() async {
    try {
      await AlbumRepository.wipeAll();
    } catch (_) {}
    _retry();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_Boot>(
      future: _boot,
      builder: (context, snap) {
        if (snap.hasData) {
          return PhotoMergerApp(theme: snap.data!.theme, state: snap.data!.state);
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(
            backgroundColor: const Color(0xFF0F1115),
            body: Center(
              child: snap.hasError
                  ? _BootError(error: '${snap.error}', onRetry: _retry, onReset: _reset)
                  : const Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('🖼️', style: TextStyle(fontSize: 44)),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Photo Highlighter load ho raha hai…', style: TextStyle(color: Colors.white70)),
                    ]),
            ),
          ),
        );
      },
    );
  }
}

class _BootError extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  final VoidCallback onReset;
  const _BootError({required this.error, required this.onRetry, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('⚠️ App start nahi ho paya', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(error, maxLines: 8, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 20),
        FilledButton(onPressed: onRetry, child: const Text('Dobara try karein')),
        const SizedBox(height: 10),
        OutlinedButton(onPressed: onReset, child: const Text('Album data reset karke start karein')),
      ]),
    );
  }
}

class PhotoMergerApp extends StatelessWidget {
  final ThemeController theme;
  final AppState state;
  const PhotoMergerApp({super.key, required this.theme, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      controller: theme,
      builder: (context, palette) => MaterialApp(
        title: 'Photo Merger & Highlighter',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(palette),
        themeAnimationDuration: Duration.zero,
        // One shared backdrop snapshot for all button-level glass blurs.
        builder: (context, child) => BackdropGroup(child: child!),
        home: HomeScreen(state: state),
      ),
    );
  }
}
