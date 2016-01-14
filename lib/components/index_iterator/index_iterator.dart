@HtmlImport('index_iterator.html')
library lib.index_iterator;

import 'dart:async';

import "package:polymer_autonotify/polymer_autonotify.dart";
import "package:observe/observe.dart";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../services/logger.dart';

@PolymerRegister('index-iterator')
class IndexIterator extends PolymerElement with AutonotifyBehavior, Observable {

  // states
  static const String STOPPED = "STOPPED";
  static const String PLAYING = "PLAYING";
  static const String PAUSED = "PAUSED";

  @observable @Property(notify: true, observer: 'indexChanged')
  int index = 0;           // the current index

  @observable @Property(notify: true, observer: 'startIndexChanged')
  int startIndex = 0;      // the starting index

  @observable @Property(notify: true, observer: 'endIndexChanged')
  int endIndex;            // the ending index

  @observable @Property(notify: true)
  int step = 1;            // how far, and in which direction, to step with prev() or next()

  @observable @Property(notify: true, observer: 'intervalChanged')
  num interval = 1;        // interval, in seconds, between index changes

  @observable @Property(notify: true)
  bool loop = false;       // should the index loop back to the beginning?

  @observable @Property(notify: true)
  bool autoStart = false;  // should the timer start automatically?

  @observable
  String state = STOPPED;

  Timer _timer;
  Duration _duration;

  IndexIterator.created() : super.created();

  void ready() {
    log.info("$runtimeType::ready()");
  }

  void _setupDuration() {
    // setup the Duration object
    _duration = new Duration(seconds: interval);
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  // "endIndex" is the only required attribute
  @reflectable
  void endIndexChanged(newValue, oldValue) {
    log.info("$runtimeType::endIndexChanged(): $endIndex");

    if (autoStart && endIndex != null) {
      start();
    }
  }

  // respond to any change in the "interval" attribute
  @reflectable
  void intervalChanged([newValue, oldValue]) {
    log.info("$runtimeType::intervalChanged(): $interval");

    if (interval == null || interval <= 0) {
      log.severe("$runtimeType::intervalChanged(): ERROR: interval -- $interval");
      return;
    }

    _setupDuration();

    // if we're already playing, restart the timer with the new interval
    if (state == PLAYING) {
      _stopTimer();
      _timer = new Timer.periodic(_duration, next);
    }
  }

  @reflectable
  void startIndexChanged(newValue, oldvalue) {
    reset();
  }

  @reflectable
  void indexChanged(newValue, oldValue) {
    fire('index-changed', detail: index);
  }

  void start() {
    if (endIndex == null) {
      log.severe("$runtimeType::start() -- ERROR: Iterator invalid.");
      return;
    }

    if (state == PLAYING) {
      return;
    }

    // kill any existing timer
    _stopTimer();

    if (_duration == null) {
      _setupDuration();
    }

    // start the timer
    _timer = new Timer.periodic(_duration, next);

    state = PLAYING;
  }

  void pause() {
    // kill the timer and record that we're paused
    _stopTimer();
    state = PAUSED;
  }

  void stop() {
    // kill the timer, reset the index, and record that we're stopped
    _stopTimer();
    reset();
    state = STOPPED;
  }

  void reset() {
    index = startIndex;
  }

  void next([Timer timer = null]) {
    if (endIndex == null) {
      log.severe("$runtimeType::next() -- ERROR: Iterator invalid.");
      return;
    }

    bool nextAvailable = false;

    if (!step.isNegative) {
      if (index < endIndex) {
        nextAvailable = true;
      }
    }
    else if (index > endIndex) {
      nextAvailable = true;
    }

    if (nextAvailable) {
      index += step;
    }
    else {
      if (loop) {
        reset();
      }
      else if (state == PLAYING) {
        stop();
      }
    }

    log.info("$runtimeType::next() -- $index");
  }

  void prev([Timer timer = null]) {
    if (endIndex == null) {
      log.severe("$runtimeType::prev() -- ERROR: Iterator invalid.");
      return;
    }

    bool prevAvailable = false;

    if (!step.isNegative) {
      if (index > startIndex) {
        prevAvailable = true;
      }
    }
    else if (index < startIndex) {
      prevAvailable = true;
    }

    if (prevAvailable) {
      index -= step;
    }
    else {
      if (loop) {
        index = endIndex;
      }
      else if (state == PLAYING) {
        stop();
      }
    }

    log.info("$runtimeType::prev() -- $index");
  }
}