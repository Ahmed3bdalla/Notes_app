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
    int index = Get.arguments;
    controller.titleController.text = controller.Nlist[index]["Title"];
    controller.contentController.text = controller.Nlist[index]["Description"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              // ignore: duplicate_ignore,
              onPressed: () {
                if (controller.contentController.text.isNotEmpty) {
                  controller.updateNote(
                      notekey: controller.Nlist[index]["key"],
                      title: controller.titleController.text,
                      content: controller.contentController.text);
                  Get.offAll(() => MyHomePage());
                } else {
                  Get.defaultDialog(
                    title: "Wraning",
                    content: const Text("please write your Note"),
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
