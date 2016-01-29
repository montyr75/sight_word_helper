library sight_word_helper.lib.word_list;

import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import "package:polymer/polymer.dart";

class WordList extends Observable {
  @observable final String name;
  @observable final String displayName;
  @observable List<String> wordList;
  @observable bool selected;

  WordList(String this.name, String this.displayName, List<String> wordList, this.selected) {
    this.wordList = new ObservableList.from(wordList);
  }

  WordList.fromMap(map) : this(map["name"], map["displayName"], map["wordList"], map["selected"]);

  @override String toString() => "$name: $selected";
}
