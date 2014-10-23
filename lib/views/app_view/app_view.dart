library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:sight_word_helper/model/model.dart';
import '../../components/index_iterator/index_iterator.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const String CLASS_NAME = "AppView";

  @observable Model model = new Model();
  @observable IndexIterator wordDisplayIterator;

  // non-visual initialization can be done here
  AppView.created() : super.created() {
    model.onWordListUpdated.listen((_) {
      wordDisplayIterator.reset();
    });
  }

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");

    wordDisplayIterator = $["word-iterator"];
  }

  void nextSlide(Event event, var detail, Element target) {
    print("$CLASS_NAME::nextSlide()");

    wordDisplayIterator.next();
  }

  void prevSlide(Event event, var detail, Element target) {
    print("$CLASS_NAME::prevSlide()");

    wordDisplayIterator.prev();
  }

  void slideshowIndexChanged(Event event, int detail, Element target) {
    model.updatePhraseList(model.wordList[detail]);
  }

//  void wordListSelected(Event event, var detail, PolymerSelector target) {
//    // use detail["isSelected"] to determine if a list is being selected or deselected
//
//    // gotta check the selectedIndex async-style to allow the bindings to update (target.selectedIndex)
//    Timer.run(() {
//      print("SettingsView::wordListSelected()");
//
//      if (target.selectedItem != null) {
//        model.selectedListIndexes = target.selectedItem.map((Element el) => int.parse(el.dataset['index'])).toList();
//      }
//    });
//  }

  void submit(Event event, var detail, Element target) {
    // prevent app reload on <form> submission
    event.preventDefault();
  }
}

