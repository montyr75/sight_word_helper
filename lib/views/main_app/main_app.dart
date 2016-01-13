@HtmlImport('main_app.html')
library sight_word_helper.lib.views.main_app;

import 'dart:html';

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/av_icons.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_card.dart';
import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../services/logger.dart';
import '../../model/app_model/app_model.dart';
//import '../../components/index_iterator/index_iterator.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement with AutonotifyBehavior, Observable {

  @observable AppModel model;
  @observable bool submitEnabled = true;
//  @observable IndexIterator wordDisplayIterator;

  PaperDrawerPanel _drawerPanel;

//  @observable bool testCheck = true;

  MainApp.created() : super.created();

  void ready() {
    log.info("$runtimeType::ready()");

    model = $['model'];
    _drawerPanel = $['drawer-panel'];

//    wordDisplayIterator = $["word-iterator"];
  }

  @reflectable
  void wordListUpdated([_, __]) {
    log.info("$runtimeType::wordListUpdated()");

//    wordDisplayIterator.reset();
  }

  testCheckChanged(bool newValue, bool oldValue) {
//    print("testCheckChanged - $testCheck");
  }

  @reflectable
  void nextSlide([_, __]) {
    log.info("$runtimeType::nextSlide()");

//    wordDisplayIterator.next();
  }

  @reflectable
  void prevSlide([_, __]) {
    log.info("$runtimeType::prevSlide()");

//    wordDisplayIterator.prev();
  }

  void slideshowIndexChanged(Event event, int detail) {
//    model.updatePhraseList(model.wordList[detail]);
  }

  @reflectable
  void wordListSelectionChanged([_, __]) {
    log.info("$runtimeType::wordListSelectionChanged()");

    submitEnabled = model.mapList.any((Map list) => list['selected']);
  }

  @reflectable
  void updateWordList([_, __]) {
    log.info("$runtimeType::updateWordList()");

    _drawerPanel.closeDrawer();
    model.updateWordList();
  }
}

