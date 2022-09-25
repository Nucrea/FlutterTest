import 'package:flutter/material.dart';
import 'package:quiz_app/api/quiz_api.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';
import 'package:rxdart/rxdart.dart';


enum QuizViewModelEvents {
  quizFinished,
  quizExit,
  goHome,
}


class QuizViewModel extends ChangeNotifier {
  final _eventsSubject = PublishSubject<QuizViewModelEvents>();
  Stream<QuizViewModelEvents> get eventsStream => _eventsSubject.stream;

  List<QuizModel> _quizzes = [];
  Map<int, bool> _quizAnswers = {};
  int _currentIndex = -1;
  bool _isLoading = false;
  bool _isError = false;

  List<QuizModel> get quizzes => _quizzes;
  set quizzes(List<QuizModel> value) { _quizzes = value; notifyListeners(); }

  bool get isLoading => _isLoading;
  set isLoading(bool val) { _isLoading = val; notifyListeners(); }
  
  bool get isError => _isError;
  set isError(bool val) { _isError = val; notifyListeners(); }

  int get currentIndex => _currentIndex;
  set currentIndex(int val) { _currentIndex = val; notifyListeners(); }

  int get totalQuestions => _quizzes.length;
  int get totalAnswers => _quizAnswers.entries.length;
  int get totalGoodAnswers => _quizAnswers.entries.fold(0, (value, element) => value += element.value? 1 : 0);
  int get totalBadAnswers => _quizAnswers.entries.fold(0, (value, element) => value += element.value? 0 : 1);

  void clear() {
    currentIndex = -1;
    _quizAnswers = {};
    quizzes = [];
    isError = false;
    isLoading = false;
  }

  void loadQuizzes(QuizCategoryModel category, String diffuculty) async {
    isLoading = true;
    isError = false;
    quizzes = [];
    _quizAnswers = {};
    currentIndex = -1;

    final response = await QuizApi.getQuizzes(      
      limit: category.questionsCount,
      category: category.name,
      difficulty: diffuculty,
    );

    if (!response.result) {
      isError = true;
    } else {
      quizzes = response.value!;
      currentIndex = 0;
    }

    isLoading = false;
  }

  void answerQuiz(QuizModel quiz, String answer) async {
    _quizAnswers[quiz.id] = quiz.correct_answers['${answer}_correct']!;

    if (currentIndex >= quizzes.length - 1) {
      _eventsSubject.add(QuizViewModelEvents.quizFinished);
      return;
    }

    currentIndex++;
  }

  void exitQuiz() {
    _eventsSubject.add(QuizViewModelEvents.quizExit);
  }

  void saveToFirebase() async {
    //TODO
  }
}