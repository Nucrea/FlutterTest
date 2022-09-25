import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/pages/question_page.dart';
import 'package:quiz_app/pages/results_page.dart';
import 'package:quiz_app/viewmodels/quiz_viewmodel.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;
    Widget? page;

    switch(settings.name) {
      case '/quiz':
        page = QuestionPage(
          difficulty: arguments!['difficulty'],
          quizCategory: arguments!['category'],
        );
        break;
      case '/results':
        page = const ResultsPage();
        break;
      case '/':
      default:
        page = const HomePage();
        break;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => page!,
    );
  }
}