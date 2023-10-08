// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
  File? img;
  ImagePicker imagePicker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var pickedimg;
  String? imagename;

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
                  Navigator.popAndPushNamed(context, "HomePage");
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
        ]),
      ),
    );
  }
}
