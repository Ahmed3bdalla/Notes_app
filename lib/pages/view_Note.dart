// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky/Controller/Note_controller.dart';
import 'package:sticky/pages/HomePage.dart';

// ignore: camel_case_types, must_be_immutable
class view_Note extends StatelessWidget {
  view_Note({super.key});
  NoteController controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Note"),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Warning"),
                        content:
                            const Text("Are you sure to delete this Note?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.deleteNote(
                                    notekey: controller.notekey!);
                                Get.offAll(() => MyHomePage());
                              },
                              child: const Text("Ok"))
                        ],
                      );
                    });
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Text(
            controller.titleController.text,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 5,
            height: 20,
          ),
          Text(
            controller.contentController.text,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ]),
      ),
    );
  }
}
