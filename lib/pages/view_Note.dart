// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sticky/pages/HomePage.dart';

// ignore: camel_case_types, must_be_immutable
class view_Note extends StatefulWidget {
  String? title;
  String? descreption;
  int? notekey;
  view_Note(
      {super.key,
      required this.title,
      required this.descreption,
      required this.notekey});

  @override
  State<view_Note> createState() => _view_NoteState();
}

// ignore: camel_case_types
class _view_NoteState extends State<view_Note> {
  final noteref = Hive.box("note");
  void deleteNote({required int notekey}) async {
    await noteref.delete(notekey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("View Note")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Text(
            "${widget.title}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 5,
            height: 20,
          ),
          Text(
            "${widget.descreption}",
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text("Wraning"),
                          content: const Text("Are you sure to Delete this?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  deleteNote(notekey: widget.notekey!);
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const MyHomePage();
                                  }));
                                },
                                // ignore: prefer_const_constructors
                                child: Text("Ok")),
                          ]);
                    });
              },
              child: const Text(
                "Delete",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("HomePage");
              },
              child: const Text(
                "Back",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }
}
