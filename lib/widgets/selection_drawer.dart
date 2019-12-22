import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_config.dart' show log;
import '../blocs/word_list_selection/word_list_selection.dart';
import '../blocs/word_lists/word_lists.dart';
import '../models/word_list.dart';
import '../repositories/word_repository.dart';

class SelectionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log.info("$runtimeType::build()");

    return Drawer(
      child: BlocBuilder<WordListSelectionBloc, WordListSelectionState>(
        builder: (BuildContext context, WordListSelectionState state) {
          return ListView(
            children: <Widget>[
//              DrawerHeader(
//                child: const Text('Select Word Lists'),
//              ),
              ...RepositoryProvider.of<WordRepository>(context).allWordLists.map((WordList list) {
                return CheckboxListTile(
                  title: Text(list.displayName),
                  subtitle: Text(list.name),
                  value: state.isSelected(list),
                  onChanged: (bool selected) =>
                      BlocProvider.of<WordListSelectionBloc>(context).add(ToggleSelectionEvent(list)),
                );
              }).toList(),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.check, color: Colors.green,),
                    const Text(' Update Word List'),
                  ],
                ),
                onPressed: state.isNotEmpty ? () {
                  Navigator.pop(context);
                  BlocProvider.of<WordListsBloc>(context).add(SetSelectedWordListsEvent(state.selectedWordLists));
                } : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
