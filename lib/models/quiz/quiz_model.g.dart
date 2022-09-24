// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      json['id'] as int,
      json['question'] as String,
      Map<String, String?>.from(json['answers'] as Map),
      json['multiple_correct_answers'] as bool,
      Map<String, String?>.from(json['correct_answers'] as Map),
      json['explanation'] as String,
      json['tip'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['category'] as String,
      json['difficulty'] as String,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'multiple_correct_answers': instance.multiple_correct_answers,
      'correct_answers': instance.correct_answers,
      'explanation': instance.explanation,
      'tip': instance.tip,
      'tags': instance.tags,
      'category': instance.category,
      'difficulty': instance.difficulty,
    };
