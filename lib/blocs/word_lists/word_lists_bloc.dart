import 'package:bloc/bloc.dart';

import '../../app_config.dart' show log;
import 'word_lists_state.dart';
import 'word_lists_events.dart';

class WordListsBloc extends Bloc<WordListsEvent, WordListsState> {
  @override
  WordListsState get initialState => WordListsState.initial();

  WordListsBloc() {
    log.info("$runtimeType()");
  }

  @override
  Stream<WordListsState> mapEventToState(WordListsEvent event) async* {
    if (event is SetSelectedWordEvent) {
      yield state.setSelectedWord(event.word);
    }
    else if (event is SetSelectedWordListsEvent) {
      yield state.setSelectedWordLists(event.wordLists);
    }
  }
}