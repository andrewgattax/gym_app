// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_workout/pages/workouts_page.dart';
import 'package:my_workout/utilities/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Colors.white70],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter)
        ),
        child: Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MyWorkout',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Keep track of your workout plans',
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutsPage(),)
            );
          },
          icon: Icon(Icons.fitness_center_rounded),
          label: Text('Go Workout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor, // Colore del bottone
            foregroundColor: Colors.white, // Colore del testo e icona
            padding: EdgeInsets.all(20),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 60),
        Text(
          '@andrewgat.tax_2024',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    ),
        ),
      ),
    );
  }
}