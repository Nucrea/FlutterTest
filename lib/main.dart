import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quiz_app.dart';
import 'package:quiz_app/viewmodels/quiz_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => QuizViewModel()
          ),
        ],
        child: const QuizApp(),
    )
  );
}
