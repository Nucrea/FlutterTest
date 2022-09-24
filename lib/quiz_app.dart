import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/':(context) => const HomePage(),
      }
    );
  }
}