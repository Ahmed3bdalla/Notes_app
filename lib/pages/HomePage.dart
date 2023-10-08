// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sticky/pages/Edit_Note.dart';
import 'package:sticky/pages/view_Note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // take ref from box to make operations on it like (add , delete , getData ,.....)
  final noteref = Hive.box("note");
  // to store data in this list after get it.
  List<Map<String, dynamic>> notesData = [];
  String? title;
  String? discreption;

  void getNotes() async {
    setState(() {
      notesData = noteref.keys.map((e) {
        final currentNote = noteref.get(e);
        return {
          "key": e,
          "Title": currentNote["Title"],
          "Description": currentNote["Description"],
          // "ImageName": currentNote["ImageName"]
        };
      }).toList();
    });
    debugPrint("Notes length : ${notesData.length}");
  }

  List<Map<String, dynamic>> filteredNotes = [];
  void filterNotes({required String input}) {
    setState(() {
      filteredNotes = notesData.where((element) {
        return element["Title"]
            .toString()
            .toLowerCase()
            .startsWith(input.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    getNotes();
    // TODO: implement initState
    super.initState();
  }

  bool searchopened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (searchopened == false) {
                  setState(() {
                    searchopened = true;
                  });
                } else {
                  setState(() {
                    searchopened = false;
                  });
                }
              },
              icon: searchopened == true
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search))
        ],
        automaticallyImplyLeading: false,
        title: searchopened == false
            ? const Text("Notes app")
            : TextFormField(
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: 1,
                onChanged: (value) {
                  filterNotes(input: value);
                },
              ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.blue,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return view_Note(
                      title: filteredNotes.isEmpty
                          ? notesData[index]["Title"]
                          : filteredNotes[index]["Title"],
                      descreption: filteredNotes.isEmpty
                          ? notesData[index]["Description"]
                          : filteredNotes[index]["Description"],
                      notekey: filteredNotes.isEmpty
                          ? notesData[index]["key"]
                          : filteredNotes[index]["key"],
                    );
                  }));
                },
                isThreeLine: true,
                title: Text(
                  filteredNotes.isEmpty
                      ? "${notesData[index]["Title"]}"
                      : filteredNotes[index]["Title"],
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  filteredNotes.isEmpty
                      ? "${notesData[index]["Description"]}"
                      : filteredNotes[index]["Title"],
                  maxLines: 1,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Edit_Note(
                        title: filteredNotes.isEmpty
                            ? notesData[index]["Title"]
                            : filteredNotes[index]["Title"],
                        discreption: filteredNotes.isEmpty
                            ? notesData[index]["Description"]
                            : filteredNotes[index]["Description"],
                        notekey: filteredNotes.isEmpty
                            ? notesData[index]["key"]
                            : filteredNotes[index]["key"],
                      );
                    }));
                  },
                ),
              ),
            );
          },
          separatorBuilder: (context, i) {
            return const Divider();
          },
          itemCount:
              filteredNotes.isEmpty ? notesData.length : filteredNotes.length),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          // showModalBottomSheet(
          //     isDismissible: false,
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //         height: 700,
          //         margin: EdgeInsets.all(10),
          //         child: ListView(children: [
          //           TextField(
          //             maxLength: 50,
          //             maxLines: 1,
          //             onChanged: (value) {
          //               setState(() {
          //                 title = value;
          //               });
          //             },
          //             decoration: const InputDecoration(hintText: "Title"),
          //           ),
          //           TextField(
          //             maxLines: 1,
          //             maxLength: 100,
          //             onChanged: (value) {
          //               setState(() {
          //                 discreption = value;
          //               });
          //             },
          //             decoration: const InputDecoration(hintText: "Note"),
          //           ),
          //           ElevatedButton(
          //               onPressed: () {
          //                 try {
          //                   if (title != null && discreption != null) {
          //                     addNote(title: title!, description: discreption!);
          //                     getNotes();
          //                     Navigator.pop(context);
          //                   } else {
          //                     showDialog(
          //                         context: context,
          //                         builder: (context) {
          //                           return const AlertDialog(
          //                             title: Text("Error...!"),
          //                             content:
          //                                 Text("please write y Title & Note"),
          //                           );
          //                         });
          //                   }
          //                 } catch (e) {
          //                   print(e);
          //                 }
          //               },
          //               child: Text("Add Note"))
          //         ]),
          //       );
          //     });
          Navigator.of(context).pushNamed("Add_Note");
        },
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
