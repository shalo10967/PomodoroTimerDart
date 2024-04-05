import 'package:flutter/material.dart';
import 'package:timepomodoro/appContainer/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87)
            .copyWith(background: Colors.black),
      ),
      home: const MainScreen(),
    );
  }
}
