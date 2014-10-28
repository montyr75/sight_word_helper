library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import 'package:sight_word_helper/model/model.dart';
import '../../components/index_iterator/index_iterator.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  // initialize system log
  bool _logInitialized = initLog();

  @observable Model model = new Model();
  @observable IndexIterator wordDisplayIterator;
  @observable bool submitEnabled = true;

  @observable bool testCheck = true;

  // non-visual initialization can be done here
  AppView.created() : super.created() {
    model.onWordListUpdated.listen((_) {
      wordDisplayIterator.reset();
    });
  }

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");

    wordDisplayIterator = $["word-iterator"];
  }

  testCheckChanged(oldValue) {
    print("testCheckChanged - $testCheck");
  }

  void nextSlide(Event event, var detail, Element target) {
    log.info("$runtimeType::nextSlide()");

    wordDisplayIterator.next();
  }

  void prevSlide(Event event, var detail, Element target) {
    log.info("$runtimeType::prevSlide()");

    wordDisplayIterator.prev();
  }

  void slideshowIndexChanged(Event event, int detail, Element target) {
    model.updatePhraseList(model.wordList[detail]);
  }

  void wordListSelectionChanged(Event event, var detail, Element target) {
    log.info("$runtimeType::wordListSelectionChanged()");

    submitEnabled = model.mapList.any((Map list) => list['selected']);
  }

  void updateWordList(Event event, var detail, Element target) {
    $['scaffold'].togglePanel();
    model.updateWordList();
  }
}

