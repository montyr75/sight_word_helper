library sight_word_helper.web.main;

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer/polymer.dart';

import 'package:sight_word_helper/views/main_app/main_app.dart';
import 'package:sight_word_helper/services/logger.dart' as Logger;

const String APP_NAME = "sight_word_helper";

main() async {
  Logger.log = Logger.initLog(APP_NAME);
  await initPolymer();
}
