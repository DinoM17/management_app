import 'dart:convert';

import 'package:flutter/material.dart';
import 'dropdownList.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _dropdownValue = '';
  List<String> values = [""];
  Map<String, dynamic> jsonLista = {"key": 2}; //jsonEncode, jsonDecode
  DateTime now = DateTime.now();
  TextEditingController additionalValueController = TextEditingController();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/list1.txt');
  }

  Future<List<String>> readList() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      if (contents == "") {
        return [""];
      }
      return contents.split(';');
    } catch (e) {
      return [""];
    }
  }

  Future<File> writeList() async {
    final file = await _localFile;
    String contents = "";
    for (String i in values) {
      contents += i;
      contents += ';';
    }
    return file.writeAsString(contents.substring(0, contents.length - 1));
  }

  void _onDropdownSelect(String? newValue) {
    setState(() {
      _dropdownValue = newValue!;
    });
  }

  void _onTextFieldChanged(String v) {
    additionalValueController.text = v;
    additionalValueController.selection = TextSelection(
      baseOffset: v.length,
      extentOffset: v.length,
    );
  }

  void _onTextFieldCompleted() {
    setState(() {
      if (additionalValueController.text != "") {
        if (!values.contains(additionalValueController.text)) {
          values.add(additionalValueController.text);
          writeList();
        }
        additionalValueController.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readList().then((List<String> value) {
      setState(() {
        values = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Management"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: additionalValueController,
                onChanged: _onTextFieldChanged,
                showCursor: true,
                onEditingComplete: _onTextFieldCompleted,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Input",
                ),
              ),
              DropdownList(
                dropdownValue: _dropdownValue,
                dropdownFunction: _onDropdownSelect,
                values: values,
              ),
              Text('$now'),
            ],
          ),
        ),
      ),
    );
  }
}
