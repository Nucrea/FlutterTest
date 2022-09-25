import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/viewmodels/quiz_viewmodel.dart';
import 'package:quiz_app/widgets/data_row_widget.dart';
import 'package:quiz_app/widgets/quiz_appbar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({
    super.key,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late QuizViewModel quizViewModel;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    quizViewModel = Provider.of<QuizViewModel>(context, listen: false);
    subscription = quizViewModel.eventsStream.listen(handleEvents);
  }

  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void handleEvents(QuizViewModelEvents event) {
    switch(event) {
      case QuizViewModelEvents.goHome:
      case QuizViewModelEvents.quizFinished:
      case QuizViewModelEvents.quizExit:
        Navigator.of(context).pop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizAppbar(),
      body: Consumer<QuizViewModel>(
        builder: (ctx, quizViewModel, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your test is finished', textScaleFactor: 1.2),
                const SizedBox(height: 20),
                DataRowWidget(title: 'total questions', value: quizViewModel.totalQuestions.toString()),
                DataRowWidget(title: 'total answers', value: quizViewModel.totalAnswers.toString()),
                DataRowWidget(title: 'right answers', value: quizViewModel.totalGoodAnswers.toString()),
                DataRowWidget(title: 'wrong answers', value: quizViewModel.totalBadAnswers.toString()),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: quizViewModel.exitQuiz, 
                  child: const Text('To home screen')
                )
              ],
            )
          );
        }
      )
    );
  }
}