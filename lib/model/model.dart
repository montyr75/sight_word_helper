library model;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';

class Model extends Object with Observable {
  // paths
  static const String WORD_DATA_URL = "resources/data/sight_words.json";
  static const String PHRASE_DATA_URL = "resources/data/phrases.json";
  static const String IMAGES_PATH = "resources/images/";

  // event streams
  StreamController _onWordListUpdated = new StreamController.broadcast();

  @observable List<Map> mapList;
  List<String> phrases;
  @observable List<String> wordList;    // current working word list
  @observable List<String> phraseList;  // current working phrase list

  Model() {
    Future wordsFuture = HttpRequest.getString(WORD_DATA_URL).then((String fileContents) {
      mapList = JSON.decode(fileContents);
    })
    .catchError((Error error) => print(error));

    Future phrasesFuture = HttpRequest.getString(PHRASE_DATA_URL).then((String fileContents) {
      phrases = JSON.decode(fileContents);
    })
    .catchError((Error error) => print(error));

    Future.wait([wordsFuture, phrasesFuture]).then((_) {
      updateWordList();
    });
  }

  void updateWordList({bool random: true}) {
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

    _onWordListUpdated.add("word-list-updated");
  }

  void updatePhraseList(String word) {
    RegExp exp = new RegExp(r"\b" + word + r"\b", caseSensitive: false);
    List<String> allPhrases = phrases.where((String phrase) => phrase.contains(exp)).toList()..shuffle();
    List<String> culledPhrases = allPhrases.take(3).toList();

    phraseList = culledPhrases.map((String phrase) => phrase.replaceAllMapped(exp, (Match m) => "<strong>${m[0]}</strong>")).toList();
  }

  // this getter allows Polymer HTML to bind to IMAGES_PATH
  String get images_path => IMAGES_PATH;

  // event streams
  Stream<String> get onWordListUpdated => _onWordListUpdated.stream;
}