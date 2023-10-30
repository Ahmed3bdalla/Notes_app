// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky/Controller/Note_controller.dart';
import 'package:sticky/pages/Edit_Note.dart';
import 'package:sticky/pages/add_Note.dart';
import 'package:sticky/pages/view_Note.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  NoteController controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Add_Note());
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.opensearch();
              },
              icon: controller.searchopen == true
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search))
        ],
        automaticallyImplyLeading: false,
        title: controller.searchopen == false
            ? const Text("Notes app")
            : TextFormField(
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: 1,
                onChanged: (value) {
                  controller.filterNotes(input: value);
                },
              ),
      ),
      body: FutureBuilder<dynamic>(
        future: controller.fetchNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.separated(
            itemCount: controller.filteredNotes.isEmpty
                ? controller.Nlist.length
                : controller.filteredNotes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: Colors.purple,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  onTap: () {
                    controller.titleController.text =
                        controller.Nlist[index]["Title"];
                    controller.contentController.text =
                        controller.Nlist[index]["Description"];
                    controller.notekey = controller.Nlist[index]["key"];
                    Get.to(() => view_Note());
                  },
                  isThreeLine: true,
                  title: Text(
                    controller.filteredNotes.isEmpty
                        ? "${controller.Nlist[index]["Title"]}"
                        : controller.filteredNotes[index]["Title"],
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 150,
                      ),
                      Text(
                        controller.filteredNotes.isEmpty
                            ? "${controller.Nlist[index]["Description"]}"
                            : controller.filteredNotes[index]["Description"],
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Text(
                          controller.filteredNotes.isEmpty
                              ? "${controller.Nlist[index]["CreatedAt"]}"
                              : controller.filteredNotes[index]["CreatedAt"],
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.titleController.text =
                          controller.Nlist[index]["Title"];
                      controller.contentController.text =
                          controller.Nlist[index]["Description"];
                      controller.notekey = controller.Nlist[index]["key"];
                      Get.to(() => Edit_Note());
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, i) {
              return const Divider();
            },
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// Column(
//                   crossAxisAlignment = CrossAxisAlignment.start,
//                   children = [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 150,
//                     ),
//                     Text(
//                     controller.filteredNotes.isEmpty
//                         ? "${controller.Nlist[index]["Description"]}"
//                         : controller.filteredNotes[index]["Description"],
//                     maxLines: 2,
//                   ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 25,
//                     ),
//                     Text(
//                         controller.filteredNotes.isEmpty
//                             ? "${controller.Nlist[index]["CreatedAt"]}"
//                             : controller.filteredNotes[index]["CreatedAt"],
//                         maxLines: 1,
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),