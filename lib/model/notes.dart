import 'package:simple_note/utils/constants.dart';

class Notes {
  final int id;
  final String title;
  final String note;

  Notes({this.id, this.title, this.note});

  Map<String, dynamic> toMap() =>
      {Constants.ID: id, Constants.TITLE: title, Constants.NOTE: note};

  @override
  String toString() {
    return 'Notes{id: $id, name: $title, age: $note}';
  }
}
