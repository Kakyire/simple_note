import 'package:flutter/material.dart';
import 'package:simple_note/ui/add_new_note.dart';
import 'package:simple_note/ui/edit_note.dart';
import 'package:simple_note/ui/home.dart';
import 'package:simple_note/ui/read_note.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static final String addNote = ' /add_note';
  static final String readNote = ' /read_note';
  static final String editNote = ' /edit_note';
  static final String home = '/';



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        App.home: (context) => Home(),
        App.addNote: (context) => AddNote(),
        App.readNote: (context) => ReadNote(),
        App.editNote: (context) => EditNote(),
      },
    );
  }
}

