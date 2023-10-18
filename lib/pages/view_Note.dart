// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sticky/pages/HomePage.dart';

// ignore: camel_case_types, must_be_immutable
class view_Note extends StatefulWidget {
  String? title;
  String? descreption;
  int? notekey;
  String? time;
  view_Note(
      {super.key,
      required this.title,
      required this.descreption,
      required this.notekey,
      required this.time});

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
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("View Note")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Text(
            "${widget.title}",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Divider(
            thickness: 5,
            height: h / 20,
          ),
          Text(
            "${widget.descreption}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: h / 30,
          ),
          Text(
            "${widget.time}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: h / 35,
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
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const MyHomePage();
                                  }), (route) => false);
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
        ]),
      ),
    );
  }
}
