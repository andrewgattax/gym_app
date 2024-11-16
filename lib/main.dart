import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:my_workout/database/database_service.dart';
import 'package:my_workout/pages/home_page.dart';
import 'package:my_workout/providers/workout_provider.dart';
import 'package:my_workout/utilities/theme.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
    if ((Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // Usa `sqflite_common_ffi` per piattaforme desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(ChangeNotifierProvider(
    create: (_) => WorkoutProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyWorkout',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
