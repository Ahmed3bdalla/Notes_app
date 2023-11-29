// ignore: file_names
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky/Controller/Note_controller.dart';
import 'package:sticky/pages/HomePage.dart';
import 'package:sticky/widgets/Custom_Textfield.dart';

// ignore: camel_case_types
class Add_Note extends StatelessWidget {
  Add_Note({super.key});
  NoteController controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    controller.titleController.text = "";
    controller.contentController.text = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // ignore: unnecessary_null_comparison
                if (controller.contentController.text.isNotEmpty) {
                  controller.addNote(
                      title: controller.titleController.text,
                      content: controller.contentController.text);
                  Get.offAll(() => MyHomePage());
                } else {
                  Get.defaultDialog(
                    title: 'Warning',
                    content: const Text("Empty Content"),
                  );
                }
              })
        ],
      ),
      body: ListView(children: [
        CustomTextField(
            controller: controller.titleController,
            labeltext: "Title",
            maxlines: 1,
            maxLength: 25),
        CustomTextField(
            controller: controller.contentController,
            labeltext: "Note",
            maxlines: null,
            maxLength: null),
      ]),
    );
  }
}
