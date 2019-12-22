import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

import '../models/word_list.dart';

part 'word_repository.g.dart';

class WordRepository {
  List<WordList> _allWordLists;
  UnmodifiableListView<WordList> get allWordLists => UnmodifiableListView<WordList>(_allWordLists);

  WordRepository() {
    _allWordLists = _sightWords.map((Map<String, dynamic> json) => WordList.fromJson(json)).toList();
  }
}

@JsonLiteral('../data/sight_words.json', asConst: true)
UnmodifiableListView<Map<String, dynamic>> get _sightWords => UnmodifiableListView<Map<String, dynamic>>(_$_sightWordsJsonLiteral);

@JsonLiteral('../data/phrases.json', asConst: true)
UnmodifiableListView<String> get sightWordPhrases => UnmodifiableListView<String>(_$sightWordPhrasesJsonLiteral);