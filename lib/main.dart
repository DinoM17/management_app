import 'package:flutter/material.dart';
import 'dropdownList.dart';

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
  List<String> _values = ["", "Dino", "Lejla"];
  TextEditingController additionalValueController = TextEditingController();
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
        _values.add(additionalValueController.text);
        additionalValueController.clear();
      }
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
                values: _values,
              )
            ],
          ),
        ),
      ),
    );
  }
}
