import 'package:flutter/material.dart';
import 'package:presentation/my_app.dart';
import 'package:star_movie_idf/di/app_injector.dart';

void main() async {
  await appInjector();
  runApp(
    const MyApp(),
  );
}
