import 'package:flutter/material.dart';

class QuizAppbar extends StatelessWidget with PreferredSizeWidget {
  const QuizAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}