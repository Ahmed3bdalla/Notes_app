// ignore: file_names
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class Edit_Note extends StatefulWidget {
  final String title;
  final String discreption;
  final int notekey;
  const Edit_Note(
      {super.key,
      required this.title,
      required this.discreption,
      required this.notekey});

  @override
  State<Edit_Note> createState() => _Edit_NoteState();
}

// ignore: camel_case_types
class _Edit_NoteState extends State<Edit_Note> {
  String? title;
  String? discreption;
  // ignore: prefer_typing_uninitialized_variables
  var noteref = Hive.box("note");

  void updateNote({required int notekey}) async {
    await noteref.put(notekey, {
      "Title": title,
      "Description": discreption,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Edit Note"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextFormField(
            initialValue: widget.title,
            maxLines: 1,
            maxLength: 25,
            decoration: const InputDecoration(
                filled: true,
                labelText: "Title",
                prefixIcon: Icon(Icons.title)),
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.discreption,
            minLines: 1,
            maxLines: 100,
            maxLength: 10000,
            decoration: const InputDecoration(
              filled: true,
              labelText: "Note",
              prefixIcon: Icon(Icons.note),
            ),
            onChanged: (note) {
              setState(() {
                discreption = note;
              });
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50)),
              child: const Text("Save"),
              onPressed: () {
                if (title != null && discreption != null) {
                  updateNote(notekey: widget.notekey);
                  Navigator.of(context).pushReplacementNamed("HomePage");
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Error...!"),
                          content: Text("There is no changes on this data"),
                        );
                      });
                }
              }),
        ]),
      ),
    );
  }
}
