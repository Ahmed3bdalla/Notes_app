
// ignore: file_names
// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky/Controller/Note_controller.dart';
import 'package:sticky/pages/HomePage.dart';
import '../widgets/Custom_Textfield.dart';

// ignore: camel_case_types, must_be_immutable
class Edit_Note extends StatelessWidget {
  Edit_Note({super.key});
  NoteController controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              // ignore: duplicate_ignore,
              onPressed: () {
                if (controller.contentController.text.isNotEmpty) {
                  controller.updateNote();
                  Get.offAll(() => MyHomePage());
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Wraning"),
                          content: Text("please write your Note"),
                        );
                      });
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
      ),
    );
  }
}
