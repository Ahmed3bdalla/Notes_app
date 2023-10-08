// ignore: file_names
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  ImagePicker imagePicker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var pickedimg;
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
        actions: [
          IconButton(
            tooltip: "add foto",
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            const Text(
                              "Choose your Photo",
                              style: TextStyle(fontSize: 25),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                              title: const Text("Camera"),
                              onTap: () async {
                                pickedimg = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                                if (pickedimg != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.photo_album,
                                color: Colors.blue,
                              ),
                              title: const Text("Gallary"),
                              onTap: () async {
                                pickedimg = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedimg != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        ));
                  });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextFormField(
            initialValue: widget.title,
            maxLines: 1,
            maxLength: 50,
            decoration: const InputDecoration(
                labelText: "Title", prefixIcon: Icon(Icons.title)),
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
                  Navigator.popAndPushNamed(context, "HomePage");
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
