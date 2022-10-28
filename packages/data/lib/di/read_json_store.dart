import 'dart:convert';

import 'package:flutter/services.dart';

class ReadJsonStore {
  final String path;

  const ReadJsonStore({required this.path});

  Future<Map<String, dynamic>> read() =>
      rootBundle.loadStructuredData<Map<String, dynamic>>(
          path, (value) async => json.decode(value));
}
