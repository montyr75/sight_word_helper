library labeled_paper_checkbox;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_checkbox.dart';
import '../../model/global.dart';

@CustomTag('labeled-paper-checkbox')
class LabeledPaperCheckbox extends PolymerElement {

  @PublishedProperty(reflect: true) bool checked = false;

  PaperCheckbox cb;

  LabeledPaperCheckbox.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");

    cb = $['checkbox'];
  }

  void toggleChecked(Event event, var detail, Element target) {
    log.info("$runtimeType::toggleChecked()");

    cb.checked = !cb.checked;
  }
}

