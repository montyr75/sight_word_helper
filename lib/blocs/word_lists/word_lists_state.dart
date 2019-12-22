import 'dart:collection';

import '../../app_config.dart' show log;
import '../../models/word_list.dart';
import '../../repositories/word_repository.dart' as repo;

class WordListsState {
  final List<String> words;
  final List<String> phrases;

  WordListsState._internal({this.words, this.phrases});

  factory WordListsState({List<String> words, List<String> phrases}) {
    return WordListsState._internal(
      words: UnmodifiableListView<String>(words),
      phrases: UnmodifiableListView<String>(phrases),
    );
  }

  factory WordListsState.initial() => WordListsState(words: [], phrases: []);

  WordListsState copyWith({List<String> words, List<String> phrases}) =>
      WordListsState._internal(
        words: words ?? this.words,
        phrases: phrases ?? this.phrases,
      );

  WordListsState setSelectedWord(String word) => copyWith(phrases: _updatePhrases(word));

  WordListsState setSelectedWordLists(Iterable<WordList> selectedWordLists) {
    final words = _updateWords(selectedWordLists);
    final phrases = _updatePhrases(words.first);

    return copyWith(words: words, phrases: phrases);
  }

  List<String> _updateWords(Iterable<WordList> selectedWordLists) {
    List<String> words = [];

    selectedWordLists.forEach((WordList list) {
      words.addAll(list.wordList);
    });

    return words..shuffle();
  }

  List<String> _updatePhrases(String word) {
    final exp = new RegExp(r"\b" + word + r"\b", caseSensitive: false);
    final List<String> allPhrases = repo.sightWordPhrases.where((String phrase) => phrase.contains(exp)).toList()..shuffle();
    final List<String> culledPhrases = allPhrases.take(3).toList();

    return culledPhrases.map((String phrase) =>
        phrase.replaceAllMapped(exp, (Match m) => "<strong>${m[0]}</strong>")).toList();
  }
}