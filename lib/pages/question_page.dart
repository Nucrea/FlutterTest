import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';
import 'package:quiz_app/viewmodels/quiz_viewmodel.dart';
import 'package:quiz_app/widgets/quiz_appbar.dart';
import 'package:quiz_app/widgets/quiz_question_widget.dart';

class QuestionPage extends StatefulWidget {
  final QuizCategoryModel quizCategory;
  final String difficulty;

  const QuestionPage({
    super.key, 
    required this.quizCategory, 
    required this.difficulty
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuizViewModel quizViewModel;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    quizViewModel = Provider.of<QuizViewModel>(context, listen: false);

    subscription = quizViewModel.eventsStream.listen(handleEvents);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      quizViewModel.loadQuizzes(widget.quizCategory, widget.difficulty);
    });
  }

  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void handleEvents(QuizViewModelEvents event) {
    switch(event) {
      case QuizViewModelEvents.goHome:
      case QuizViewModelEvents.quizExit:
      case QuizViewModelEvents.quizFinished:
        Navigator.of(context).pushNamedAndRemoveUntil('/results', (ModalRoute.withName('/')));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizAppbar(),
      body: Consumer<QuizViewModel>(
        builder: (ctx, quizViewModel, _) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(widget.quizCategory.name),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: quizViewModel.isLoading?
                        null : quizViewModel.exitQuiz,
                      child: const Text('Stop quiz'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: quizViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator(strokeWidth: 10))
                  : quizViewModel.isError
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.error, color: Colors.red),
                            Text('An issue occured'),
                          ],
                        )
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: quizViewModel.currentIndex >= 0
                          ? QuizQuestionWidget(
                              quiz: quizViewModel.quizzes[quizViewModel.currentIndex],
                              onAnswered: quizViewModel.answerQuiz,
                            )
                          : Container(child: const Text('Empty'))
                      ),
              )
            ],
          );
        },
      )
    );
  }
}