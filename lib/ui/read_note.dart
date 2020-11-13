import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_note/utils/constants.dart';

class ReadNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map notesInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(notesInfo[Constants.TITLE]),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10,0,10,10),
        child: ListView(
          children: [
            Text(
              notesInfo[Constants.NOTE],
              style: TextStyle(fontSize: 20, wordSpacing: 2),
            ),
          ],
        ),
      ),
    );
  }
}
