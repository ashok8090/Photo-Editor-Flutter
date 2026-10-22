import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

import '../models/constants.dart';
import '../models/hl_shape.dart';
import '../models/photo_item.dart';
import '../services/album_repository.dart';
import '../services/image_ops.dart';
import '../services/pdf_service.dart';

class AppState extends ChangeNotifier {
  final AlbumRepository album;
  AppState(this.album);

  // Simplified stub for build - full implementation in project
  List<PhotoItem> photos = [];
  bool isDark = true;

  void notify() => notifyListeners();
}
