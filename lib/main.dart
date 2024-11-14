import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:gym_app/pages/home_page.dart';
import 'package:gym_app/utilities/theme.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
    if ((Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // Usa `sqflite_common_ffi` per piattaforme desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
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
