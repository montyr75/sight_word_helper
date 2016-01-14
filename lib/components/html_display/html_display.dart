@HtmlImport('html_display.html')
library lib.html_display;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('html-display', extendsTag: 'div')
class HTMLDisplay extends DivElement with PolymerBase, PolymerMixin {

  @Property(observer: 'htmlContentChanged')
  String htmlContent;

  HTMLDisplay.created() : super.created() {
    polymerCreated();
  }

  factory HTMLDisplay() => document.createElement('div', 'html-display');

  // respond to any change in the "htmlContent" attribute
  @reflectable
  void htmlContentChanged(newValue, oldValue) {
    if (htmlContent == null) {
      htmlContent = "";
    }

    // creating a DocumentFragment allows for HTML parsing
    Polymer.dom(root).removeChild(Polymer.dom(root).firstChild);
    Polymer.dom(root).append(new DocumentFragment.html("$htmlContent"));
  }
}