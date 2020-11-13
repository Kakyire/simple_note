import 'package:flutter/cupertino.dart';
import 'package:simple_note/model/notes.dart';
import 'package:simple_note/ui/main.dart';

import 'constants.dart';
import 'db_operations.dart';

class RouteOperations {
  static addNewNote({BuildContext context, Function updateListView}) async {
    //wait for input from user ( title and note)
    //then insert it into the database
    dynamic result = await Navigator.pushNamed(context, App.addNote);
    if (result != null) {
       DBOperations.insert(
        Notes(
          title: result[Constants.TITLE],
          note: result[Constants.NOTE],
        ),
      );
      print(result);
      updateListView();
    }
  }

  //delete note when user swipe it
  //and remove it from the ListView
  static void deleteNote({int index, List<Notes> list}) async {
    DBOperations.deleteNote(list[index].id);
    list.removeAt(index);
  }

  static void readContent({BuildContext context, int index, List<Notes> list}) {
    Navigator.pushNamed(
      context,
      App.readNote,
      arguments: {
        Constants.TITLE: list[index].title,
        Constants.NOTE: list[index].note,
      },
    );
  }
}
