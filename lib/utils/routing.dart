import 'package:flutter/cupertino.dart';
import 'package:simple_note/main.dart';
import 'package:simple_note/model/notes.dart';

import 'constants.dart';
import 'db_operations.dart';

class Routing {
  static void addNote({
    BuildContext context,
    Function reloadNote,
  }) async {
    //wait for input from user ( title and note)
    //then insert it into the database
    dynamic result = await Navigator.pushNamed(context, App.addOrEditNote);
    if (result != null) {
      DBOperations.insert(
        Notes(
          title: result[Constants.TITLE],
          note: result[Constants.NOTE],
        ),
      );
    }

    print(result);

    reloadNote();
  }

  //delete note when user swipe it
  //and remove it from the ListView
  static void deleteNote({int index, List<Notes> list}) async {
    DBOperations.deleteNote(list[index].id);
    list.removeAt(index);
  }

  static void readContent({BuildContext context, int index, List<Notes> note}) {
    Navigator.pushNamed(
      context,
      App.readNote,
      arguments: {
        Constants.TITLE: note[index].title,
        Constants.NOTE: note[index].note,
      },
    );
  }

  static void editNote({
    BuildContext context,
    Function reloadNote,
    int index,
    List<Notes> note,
  }) async {
    //wait for input from user ( title and note)
    //then update the note using the passed id
    dynamic result = await Navigator.pushNamed(
      context,
      App.addOrEditNote,
      arguments: {
        Constants.TITLE: note[index].title,
        Constants.NOTE: note[index].note,
        Constants.APP_BAR_TITLE: 'Edit Note'
      },
    );
    if (result != null) {
      DBOperations.updateNotes(
        Notes(
          id: note[index].id,
          title: result[Constants.TITLE],
          note: result[Constants.NOTE],
        ),
      );
      reloadNote();
    }
  }
}
