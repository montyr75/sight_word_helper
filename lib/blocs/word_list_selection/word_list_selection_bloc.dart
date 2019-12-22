import 'package:bloc/bloc.dart';

import '../../app_config.dart' show log;
import 'word_list_selection_state.dart';
import 'word_list_selection_events.dart';
import '../word_lists/word_lists.dart';
import '../../repositories/word_repository.dart';

class WordListSelectionBloc extends Bloc<WordListSelectionEvent, WordListSelectionState> {
  @override
  WordListSelectionState get initialState => WordListSelectionState.initial();

  WordListSelectionBloc(WordRepository repo, WordListsBloc wordListsBloc) {
    log.info("$runtimeType()");

    // start off with the first word list selected
    final firstWordList = repo.allWordLists.first;
    add(ToggleSelectionEvent(firstWordList));
    wordListsBloc.add(SetSelectedWordListsEvent([firstWordList]));
  }

  @override
  Stream<WordListSelectionState> mapEventToState(WordListSelectionEvent event) async* {
    if (event is ToggleSelectionEvent) {
      yield state.toggle(event.list);
    }
  }
}