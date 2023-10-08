// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
                deleteNote(notekey: widget.notekey!);
                Navigator.pushNamed(context, "HomePage");
              },
              child: const Text(
                "Delete",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }
}
