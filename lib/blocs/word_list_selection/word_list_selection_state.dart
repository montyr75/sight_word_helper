import 'dart:collection';

import '../../models/word_list.dart';

class WordListSelectionState {
  final Set<WordList> _selectedWordLists;
  UnmodifiableListView<WordList> get selectedWordLists => UnmodifiableListView<WordList>(_selectedWordLists);

  const WordListSelectionState([Set<WordList> selectedWordLists]) : _selectedWordLists = selectedWordLists;

  factory WordListSelectionState.initial() => WordListSelectionState({});

  WordListSelectionState toggle(WordList list) {
    if (_selectedWordLists.contains(list)) {
      return WordListSelectionState(_selectedWordLists..remove(list));
    }

    return WordListSelectionState(_selectedWordLists..add(list));
  }

  bool isSelected(WordList list) => _selectedWordLists.contains(list);
  bool get isEmpty => _selectedWordLists.isEmpty;
  bool get isNotEmpty => _selectedWordLists.isNotEmpty;
}