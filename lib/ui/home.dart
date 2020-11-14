import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_note/model/notes.dart';
import 'package:simple_note/utils/db_operations.dart';
import 'package:simple_note/utils/routing.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Notes> list; // List<Notes>();

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      list = List<Notes>();
      _populateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Note'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Routing.addNote(
              context: context,
              reloadNote: _populateListView,
            );
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Add new note',
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final key = list[index].toString();
          return Dismissible(
            key: Key(key),
            onDismissed: (direction) {
              setState(() {
                Routing.deleteNote(
                  list: list,
                  index: index,
                );
              });
            },
            background: Container(
              color: Colors.red[500],
            ),
            child: Card(
              child: ListTile(
                onLongPress: () {
                  setState(() {
                    final snack = Scaffold.of(context);
                    snack.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Swipe left/right to delete note',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: snack.hideCurrentSnackBar,
                        ),
                      ),
                    );
                  });
                },
                title: Text(
                  list[index].title,
                  style: TextStyle(fontSize: 30, color: Colors.green[900]),
                ),
                onTap: () {
                  setState(() {
                    Routing.readContent(
                      index: index,
                      context: context,
                      note: list,
                    );
                  });
                },
                trailing: GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    setState(() {
                      Routing.editNote(
                          context: context,
                          index: index,
                          note: list,
                          reloadNote: _populateListView);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _populateListView() {
    DBOperations.selectNotes().then((value) {
      setState(() {
        list = value;
      });
    });
  }
}
