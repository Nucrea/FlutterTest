import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const DataRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Expanded(child: Text('.' * 100, maxLines: 1)),
        Text(value),
      ],
    );
  }
}