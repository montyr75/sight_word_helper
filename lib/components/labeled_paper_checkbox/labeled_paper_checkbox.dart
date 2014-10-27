library labeled_paper_checkbox;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_checkbox.dart';

@CustomTag('labeled-paper-checkbox')
class LabeledPaperCheckbox extends PolymerElement {

  static const String CLASS_NAME = "LabeledPaperCheckbox";

  @PublishedProperty(reflect: true) bool checked = false;

  PaperCheckbox cb;

  LabeledPaperCheckbox.created() : super.created();

  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");

    cb = $['checkbox'];
  }

  void toggleChecked(Event event, var detail, Element target) {
    print("$CLASS_NAME::toggleChecked()");

    cb.checked = !cb.checked;
  }
}

