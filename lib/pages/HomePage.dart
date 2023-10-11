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
          "Time": currentNote["Time"]
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("Add_Note");
        },
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ),
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
                decoration: const InputDecoration(
                    hintText: "Search", border: InputBorder.none),
                maxLines: 1,
                onChanged: (value) {
                  filterNotes(input: value);
                },
              ),
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.blue,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
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
                      time: filteredNotes.isEmpty
                          ? notesData[index]["Time"]
                          : filteredNotes[index]["Time"],
                    );
                  }));
                },
                title: Text(
                  filteredNotes.isEmpty
                      ? "${notesData[index]["Title"]}"
                      : filteredNotes[index]["Title"],
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
                      filteredNotes.isEmpty
                          ? "${notesData[index]["Description"]}"
                          : filteredNotes[index]["Description"],
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Text(
                        filteredNotes.isEmpty
                            ? "${notesData[index]["Time"]}"
                            : filteredNotes[index]["Time"],
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushReplacement(context,
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
