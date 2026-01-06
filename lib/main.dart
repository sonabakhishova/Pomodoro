import 'package:flutter/material.dart';
import 'package:pomodoro_app/home_screen.dart';

void main(){
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget{
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro-ro',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 103, 163, 241),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}