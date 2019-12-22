import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/word_repository.dart';
import 'blocs/word_list_selection/word_list_selection.dart';
import 'blocs/word_lists/word_lists.dart';
import 'pages/home_page.dart';

void main() => runApp(SightWordHelper());

class SightWordHelper extends StatelessWidget {
  static final wordRepo = WordRepository();
  static final wordListsBloc = WordListsBloc();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WordRepository>(
      create:  (_) => wordRepo,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WordListsBloc>(create: (_) => wordListsBloc,),
          BlocProvider<WordListSelectionBloc>(create: (_) => WordListSelectionBloc(wordRepo, wordListsBloc),),
        ],
        child: MaterialApp(
          title: 'Sight Word Helper',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
