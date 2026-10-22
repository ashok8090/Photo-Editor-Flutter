import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'hl_shape.dart';

/// Port of the augmented `Image` objects kept in the JS `images[]` array.
class PhotoItem {
  final String id;
  final String src;
  String? name;
  // Full fields from original project will be added
  PhotoItem({required this.id, required this.src, this.name});
}
