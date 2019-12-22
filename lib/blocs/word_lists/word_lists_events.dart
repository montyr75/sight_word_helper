import '../../models/word_list.dart';

abstract class WordListsEvent {}

class SetSelectedWordEvent extends WordListsEvent {
  final String word;

  SetSelectedWordEvent(this.word);
}

class SetSelectedWordListsEvent extends WordListsEvent {
  final List<WordList> wordLists;

  SetSelectedWordListsEvent(this.wordLists);
}