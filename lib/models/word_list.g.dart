// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordList _$WordListFromJson(Map<String, dynamic> json) {
  return WordList(
    json['name'] as String,
    json['displayName'] as String,
    (json['wordList'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$WordListToJson(WordList instance) => <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'wordList': instance.wordList,
    };
