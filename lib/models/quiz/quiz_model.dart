// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';


@JsonSerializable()
class QuizModel {
  final int id;
  final String question;
  final String? description;
  final Map<String, String?> answers;
  final String? explanation;
  final String? tip;
  // final List<String> tags;
  final String category;
  final String difficulty;

  @JsonKey(fromJson: _boolFromString, toJson: _boolToString)
  final bool multiple_correct_answers;

  @JsonKey(fromJson: _boolMapFromStringMap, toJson: _boolMapToStringMap)
  final Map<String, bool> correct_answers;
  
  QuizModel(this.id, this.question, this.description, this.answers, this.explanation, this.tip, this.category, this.difficulty, this.multiple_correct_answers, this.correct_answers);

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  static bool _boolFromString(String value) => value == 'true';
  static String _boolToString(bool value) => value? 'true' : 'false';

  static Map<String, bool> _boolMapFromStringMap(Map<dynamic, dynamic> value) 
    => value.map((key, value) => MapEntry(key, value == 'true'));

  static Map<String, String> _boolMapToStringMap(Map<String, bool> value)
    => value.map((key, value) => MapEntry(key, value? 'true' : 'false'));
}