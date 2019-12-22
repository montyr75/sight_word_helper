import 'package:json_annotation/json_annotation.dart';

part 'word_list.g.dart';

@JsonSerializable()
class WordList {
  final String name;
  final String displayName;
  final List<String> wordList;

  const WordList(this.name, this.displayName, this.wordList);

  factory WordList.fromJson(Map<String, dynamic> json) => _$WordListFromJson(json);
  Map<String, dynamic> toJson() => _$WordListToJson(this);
}
