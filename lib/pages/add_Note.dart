// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: camel_case_types
class Add_Note extends StatefulWidget {
  const Add_Note({super.key});

  @override
  State<Add_Note> createState() => _Add_NoteState();
}

// ignore: camel_case_types
class _Add_NoteState extends State<Add_Note> {
  final noteref = Hive.box("Note");
  String? title;
  String? discreption;

  void addNote({required String title, required String description}) async {
    await noteref.add({
      "Title": title,
      "Description": description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Note"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextFormField(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50)),
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("HomePage");
                  }),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50)),
                  child: const Text("Save"),
                  onPressed: () {
                    if (title != null && discreption != null) {
                      addNote(
                        title: title!,
                        description: discreption!,
                      );
                      Navigator.pushReplacementNamed(context, "HomePage");
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Error...!"),
                              content: Text("please fill adsfasd"),
                            );
                          });
                    }
                  }),
            ],
          )
        ]),
      ),
    );
  }
}
