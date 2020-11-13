import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_note/utils/constants.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _noteController = TextEditingController();
  final _titleController = TextEditingController();
  bool _validateTitle = false;
  bool _validateNote = false;

  //when the user leave any of the fields empty
  //show an error message
  void _controllerHandler(BuildContext context) {
    setState(() {
      if (_titleController.text.isEmpty) {
        _validateTitle = true;
        // _validateTitle = false;
      } else if (_noteController.text.isEmpty) {
        _validateNote = true;
        // _validateNote = false;
      } else {
        _validateTitle = false;
        _validateNote = false;
        Navigator.pop(context, {
          Constants.NOTE: '${_noteController.text}',
          Constants.TITLE: '${_titleController.text}',
        });
      }
    });
  }

  @override
  void dispose() {
    //dispose the controllers when the Widget dispose
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 30,
              ),
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',

                errorText: _validateTitle ? 'Title is required' : null,
              ),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontSize: 25,
                ),
                controller: _noteController,
                keyboardType: TextInputType.multiline,
                maxLines: 25,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Notes',
                  errorText: _validateNote ? 'Note is required' : null,
                ),
              ),
            ),
            Container(

              margin: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () => _controllerHandler(context),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
