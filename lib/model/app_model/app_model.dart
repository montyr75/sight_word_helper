@HtmlImport('app_model.html')
library sight_word_helper.lib.game_model;

import 'dart:html';
import 'dart:convert';
import 'dart:async';

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../services/logger.dart';

@PolymerRegister('app-model')
class AppModel extends PolymerElement with AutonotifyBehavior, Observable {

  static const String WORD_DATA_URL = "resources/data/sight_words.json";
  static const String PHRASE_DATA_URL = "resources/data/phrases.json";
  static const String IMAGES_PATH = "resources/images/";

  @observable List<Map> mapList;
  List<String> phrases;

  @observable List<String> wordList;    // current working word list
  @observable List<String> phraseList;  // current working phrase list

  AppModel.created() : super.created();

  void ready() {
    log.info("$runtimeType::ready()");

    Future wordsFuture = HttpRequest.getString(WORD_DATA_URL).then((String fileContents) {
      mapList = new ObservableList.from(JSON.decode(fileContents));
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

    mapList.forEach((Map list) {
      if (list['selected']) {
        newWordList.addAll(list['wordList']);
      }
    });

    if (random) {
      newWordList.shuffle();
    }

    wordList = newWordList;

    if (wordList.isNotEmpty) {
      updatePhraseList(wordList.first);
    }

    log.info("wordList: $wordList");

    fire("word-list-updated");
  }

  void updatePhraseList(String word) {
    log.info("$runtimeType::updatePhraseList()");

    RegExp exp = new RegExp(r"\b" + word + r"\b", caseSensitive: false);
    List<String> allPhrases = phrases.where((String phrase) => phrase.contains(exp)).toList()..shuffle();
    List<String> culledPhrases = allPhrases.take(3).toList();

    phraseList = culledPhrases.map((String phrase) => phrase.replaceAllMapped(exp, (Match m) => "<strong>${m[0]}</strong>")).toList();
  }

  // this getter allows Polymer HTML to bind to IMAGES_PATH
  String get images_path => IMAGES_PATH;

  @property
  int get lastWordIndex => wordList != null && wordList.isNotEmpty ? wordList.length -1 : 0;
}