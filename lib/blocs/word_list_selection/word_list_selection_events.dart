import '../../models/word_list.dart';

abstract class WordListSelectionEvent {}

class ToggleSelectionEvent extends WordListSelectionEvent {
  final WordList list;

  ToggleSelectionEvent(this.list);
}