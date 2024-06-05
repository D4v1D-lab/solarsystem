import 'package:flutter/material.dart';
import 'package:threebp/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solar system',
      theme: ThemeData.dark(),
      home: const OrbitAnimation(),
    );
  }
}
