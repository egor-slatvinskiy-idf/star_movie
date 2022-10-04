import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/my_app.dart';
import 'package:star_movie_idf/di/app_injector.dart';
import 'package:star_movie_idf/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await appInjector();
  runApp(const MyApp());
}
