import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteController extends GetxController {
  final noteref = Hive.box("note");
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> Nlist = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int? notekey;

  void addNote(context) async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isEmpty) {
      title = "No Title";
    }
    await noteref.add(
        {"Title": title, "Description": content, "CreatedAt": DateTime.now()});
    update();
  }

  List<Map<String, dynamic>> filteredNotes = [];
  void filterNotes({required String input}) {
    filteredNotes = Nlist.where((element) {
      return element["Title"].toString().startsWith(input.toLowerCase());
    }).toList();
    fetchNotes();
    update();
  }

  void updateNote() async {
    final title = titleController.text;
    final content = contentController.text;
    await noteref.put(notekey, {
      "Title": title,
      "Description": content,
      "CreatedAt": DateTime.now(),
    });
  }

  fetchNotes() {
    Nlist = noteref.keys.map((e) {
      final current = noteref.get(e);
      return {
        "Title": current["Title"],
        "Description": current["Description"],
        "CreatedAt": current["CreatedAt"],
        "key": e
      };
    }).toList();
    debugPrint("N length : ${Nlist.length}");
  }

  void deleteNote({required int notekey}) async {
    await noteref.delete(notekey);
    fetchNotes();
    update();
  }

  bool searchopen = false;
  void opensearch() {
    if (searchopen == false) {
      searchopen = true;
    } else {
      searchopen = false;
    }
    update();
  }
}
