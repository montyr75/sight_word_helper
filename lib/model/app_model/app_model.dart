@HtmlImport('app_model.html')
library sight_word_helper.lib.app_model;

import 'dart:html';
import 'dart:convert';
import 'dart:async';

import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../model/word_list.dart';
import '../../services/logger.dart';

@PolymerRegister('app-model')
class AppModel extends PolymerElement with AutonotifyBehavior, Observable {

  static const String WORD_DATA_URL = "resources/data/sight_words.json";
  static const String PHRASE_DATA_URL = "resources/data/phrases.json";
  static const String IMAGES_PATH = "resources/images/";

  @observable @property List<WordList> wordLists;
  List<String> phrases;

  @observable @property List<String> wordList;    // current working word list
  @observable @property List<String> phraseList;  // current working phrase list

  @observable @property int lastWordIndex;

  AppModel.created() : super.created();

  void ready() {
    log.info("$runtimeType::ready()");

    Future wordsFuture = HttpRequest.getString(WORD_DATA_URL).then((String fileContents) {
      List<Map> mapList = JSON.decode(fileContents);
      wordLists = new ObservableList.from(mapList.map((Map map) => new WordList.fromMap(map)));
    }).catchError((Error error) => log.severe(error));

    Future phrasesFuture = HttpRequest.getString(PHRASE_DATA_URL).then((String fileContents) {
      phrases = JSON.decode(fileContents);
    }).catchError((Error error) => log.severe(error));

    Future.wait([wordsFuture, phrasesFuture]).then((_) {
      updateWordList();
    });
  }

  void updateWordList({bool random: true}) {
    log.info("$runtimeType::updateWordList()");

    List<String> newWordList = [];

    wordLists.forEach((WordList list) {
      if (list.selected) {
        newWordList.addAll(list.wordList);
      }
    });

    if (random) {
      newWordList.shuffle();
    }

    wordList = new ObservableList.from(newWordList);

    if (wordList.isNotEmpty) {
      updatePhraseList(wordList.first);
    }

    fire("word-list-updated");
  }

  void updatePhraseList(String word) {
    log.info("$runtimeType::updatePhraseList()");

    RegExp exp = new RegExp(r"\b" + word + r"\b", caseSensitive: false);
    List<String> allPhrases = phrases.where((String phrase) => phrase.contains(exp)).toList()..shuffle();
    List<String> culledPhrases = allPhrases.take(3).toList();

    phraseList = new ObservableList.from(culledPhrases.map((String phrase) => phrase.replaceAllMapped(exp, (Match m) => "<strong>${m[0]}</strong>")).toList());
  }

  // this getter allows Polymer HTML to bind to IMAGES_PATH
  String get images_path => IMAGES_PATH;

  @Observe("wordList")
  void computeLastWordIndex(List<String> wordList) {
    lastWordIndex = wordList != null && wordList.isNotEmpty ? wordList.length -1 : 0;
  }
}