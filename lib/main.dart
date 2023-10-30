import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sticky/pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to get path of storage place user generator
  final documentDirectory = await getApplicationDocumentsDirectory();
  // to initialize Hive
  Hive.init(documentDirectory.path);
  // You can provide a [subDir] where the boxes should be stored.
  await Hive.initFlutter();
  // to open box
  await Hive.openBox("note");

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var messengerkey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scaffoldMessengerKey: messengerkey,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: MyHomePage());
  }
}
