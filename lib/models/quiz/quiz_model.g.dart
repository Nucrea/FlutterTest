// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      json['id'] as int,
      json['question'] as String,
      json['description'] as String?,
      Map<String, String?>.from(json['answers'] as Map),
      json['explanation'] as String?,
      json['tip'] as String?,
      json['category'] as String,
      json['difficulty'] as String,
      QuizModel._boolFromString(json['multiple_correct_answers'] as String),
      QuizModel._boolMapFromStringMap(json['correct_answers'] as Map),
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'description': instance.description,
      'answers': instance.answers,
      'explanation': instance.explanation,
      'tip': instance.tip,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'multiple_correct_answers':
          QuizModel._boolToString(instance.multiple_correct_answers),
      'correct_answers':
          QuizModel._boolMapToStringMap(instance.correct_answers),
    };
