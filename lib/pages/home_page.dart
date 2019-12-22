import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter_swiper/flutter_swiper.dart';

import '../app_config.dart' show log;
import '../blocs/word_lists/word_lists.dart';
import '../widgets/selection_drawer.dart';
import '../utils/screen_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _screenUtilsInitialized = false;
  Swiper _swiper;
  SwiperController _swiperController = SwiperController();

  double opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    log.info("$runtimeType::build()");

    if (!_screenUtilsInitialized) {
      SU.initialize(context);
      _screenUtilsInitialized = true;
      log.info("$runtimeType::build() -- INITIALIZING SU");
    }

    // set global toast context
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sight Word Helper'),
      ),
      drawer: SelectionDrawer(),
      body: SafeArea(
        child: Padding(
          padding: SU.paddingAllM,
          child: Column(
            children: <Widget>[
              BlocBuilder<WordListsBloc, WordListsState>(
                condition: _isWordsUpdated,
                builder: (BuildContext context, WordListsState state) {
                  _swiper = Swiper(
                    controller: _swiperController,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            state.words[i],
                            style: TextStyle(fontFamily: 'ABeeZee', fontSize: SU.fontSize[48]),
                          ),
                        ),
                      );
                    },
                    itemCount: state.words.length,
                    control: SwiperControl(),
                    onIndexChanged: (int i) {
                      BlocProvider.of<WordListsBloc>(context).add(SetSelectedWordEvent(state.words[i]));
                    },
                  );

                  return BlocListener<WordListsBloc, WordListsState>(
                    condition: _isWordsUpdated,
                    listener: (_, __) => Timer.run(() => _swiperController.move(0)),
                    child: SizedBox(
                      height: SU.saHeight(125),
                      child: _swiper,
                    ),
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: SU.saHeight(28)),
                  child: BlocBuilder<WordListsBloc, WordListsState>(
                    builder: (BuildContext context, WordListsState state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: state.phrases.map((String phrase) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: SU.saHeight(10)),
                                  child: Card(
                                    child: ListTile(
                                      title: Html(
                                        data: phrase,
                                        defaultTextStyle: TextStyle(fontFamily: 'ABeeZee', fontSize:  SU.fontSize[32]),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isWordsUpdated(WordListsState prev, WordListsState state) {
    if (prev.words == state.words) {
      return false;
    }

    return true;
  }

  bool _isPhrasesUpdated(WordListsState prev, WordListsState state) {
    if (prev.phrases == state.phrases) {
      return false;
    }

    return true;
  }

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }
}