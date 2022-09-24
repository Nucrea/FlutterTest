import 'package:flutter/material.dart';
import 'package:quiz_app/api/quiz_api.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';
import 'package:quiz_app/widgets/quiz_category_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizCategoryModel>? quizCategories;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  void loadQuiz() async {
    setState(() => isLoading = true);
    final quizResponse  = await QuizApi.getCategories();
    setState(() => isLoading = false);

    if (!quizResponse.result) {
      return;
    }

    setState(() => quizCategories = quizResponse.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'), 
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(
            Icons.question_mark, 
            color: Colors.white,
          ),
        )
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text('Choose your test'),
                const Spacer(),
                ElevatedButton(
                  onPressed: isLoading
                    ? null
                    : loadQuiz, 
                  child: const Text('Reload')
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 10))
              : ListView.builder(
                  itemCount: quizCategories!.length,
                  itemBuilder: (BuildContext context, int index) => 
                    QuizCategoryCardWidget(
                      quizCategory: quizCategories![index],
                      onClicked: (name) => print(name),
                    ),
                ),
          )
        ],
      )
    );
  }
}