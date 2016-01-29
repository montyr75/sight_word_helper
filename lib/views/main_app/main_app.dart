@HtmlImport('main_app.html')
library sight_word_helper.lib.views.main_app;

import 'dart:html';

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer_elements/av_icons.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_item_body.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_card.dart';
import 'package:polymer_elements/paper_progress.dart';
import 'package:polymer_elements/iron_pages.dart';
import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../services/logger.dart';
import '../../model/app_model/app_model.dart';
import '../../model/word_list.dart';
import '../../components/index_iterator/index_iterator.dart';
import '../../components/html_display/html_display.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement with AutonotifyBehavior, Observable {

  @observable @property AppModel model;
  @observable @property bool submitEnabled = true;

  @observable @property IndexIterator wordDisplayIterator;
  PaperDrawerPanel _drawerPanel;

  MainApp.created() : super.created();

  void ready() {
    log.info("$runtimeType::ready()");

    model = $['model'];
    _drawerPanel = $['drawer-panel'];

    wordDisplayIterator = $["word-iterator"];
  }

  @reflectable
  void wordListUpdated([_, __]) {
    log.info("$runtimeType::wordListUpdated()");

    wordDisplayIterator.reset();
  }

  @reflectable
  void nextSlide([_, __]) {
    log.info("$runtimeType::nextSlide()");

    wordDisplayIterator.next();
  }

  @reflectable
  void prevSlide([_, __]) {
    log.info("$runtimeType::prevSlide()");

    wordDisplayIterator.prev();
  }

  @reflectable
  void wordListIndexChanged(Event event, int index) {
    log.info("$runtimeType::wordListIndexChanged() -- index: $index");
    model?.updatePhraseList(model.wordList[index]);
  }

  @reflectable
  void wordListSelectionChanged([_, __]) {
    log.info("$runtimeType::wordListSelectionChanged()");

    submitEnabled = model.wordLists.any((WordList list) => list.selected);
  }

  @reflectable
  void updateWordList([_, __]) {
    log.info("$runtimeType::updateWordList()");

    _drawerPanel.closeDrawer();
    model.updateWordList();
  }
}

