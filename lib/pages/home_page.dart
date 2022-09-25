import 'package:flutter/material.dart';
import 'package:quiz_app/api/quiz_api.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';
import 'package:quiz_app/widgets/quiz_appbar.dart';
import 'package:quiz_app/widgets/quiz_category_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizCategoryModel>? quizCategories;
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    final quizResponse  = await QuizApi.getCategories();
    setState(() => isLoading = false);

    if (!quizResponse.result) {
      setState(() => isError = true);
      return;
    }

    setState(() => quizCategories = quizResponse.value);
  }

  void onCategoryClicked(QuizCategoryModel category) {
    Navigator.of(context).pushNamed('/quiz', arguments: {
      'category': category,
      'difficulty': 'easy',
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryWidgets = (quizCategories ?? []).map<Widget>(
      (e) => QuizCategoryCardWidget(
        quizCategory: e,
        onClicked: onCategoryClicked,
      ),
    ).toList();

    return Scaffold(
      appBar: const QuizAppbar(),
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
                    : loadCategories, 
                  child: const Text('Reload')
                ),
              ],
            ),
          ),
          Expanded(
            child: isError
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.error, color: Colors.red),
                      Text('An issue occured'),
                    ],
                  )
                )
              : isLoading
                ? const Center(child: CircularProgressIndicator(strokeWidth: 10))
                // : ListView.builder(
                //     itemCount: quizCategories!.length,
                //     itemBuilder: (BuildContext context, int index) => 
                //       QuizCategoryCardWidget(
                //         quizCategory: quizCategories![index],
                //         onClicked: onCategoryClicked,
                //       ),
                //   ),
                : Wrap(children: categoryWidgets)
          )
        ],
      )
    );
  }
}