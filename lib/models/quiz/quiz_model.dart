// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {
  final int id;
  final String question;
  final Map<String, String?> answers;
  final bool multiple_correct_answers;
  final Map<String, String?> correct_answers;
  final String explanation;
  final String tip;
  final List<String> tags;
  final String category;
  final String difficulty;
  
  QuizModel(this.id, this.question, this.answers, this.multiple_correct_answers, this.correct_answers, this.explanation, this.tip, this.tags, this.category, this.difficulty);

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}