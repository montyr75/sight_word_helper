library labeled_paper_checkbox;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_checkbox.dart';

@CustomTag('labeled-paper-checkbox')
class LabeledPaperCheckbox extends PolymerElement {

  static const String CLASS_NAME = "LabeledPaperCheckbox";

  @PublishedProperty(reflect: true) bool checked = false;

  PaperCheckbox cb;

  // non-visual initialization can be done here
  LabeledPaperCheckbox.created() : super.created();

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");

    cb = $['checkbox'];
  }

  // a sample event handler function
  void toggleChecked(Event event, var detail, Element target) {
    print("$CLASS_NAME::toggleChecked()");

    cb.checked = !cb.checked;
  }
}

