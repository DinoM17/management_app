import 'package:flutter/material.dart';
import 'dropdownList.dart';

void main() {
  runApp(const MyApp());
}

String _dropdownValue = '';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _onDropdownSelect(String? newValue) {
    setState(() {
      _dropdownValue = newValue!;
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
              DropdownList(
                dropdownValue: _dropdownValue,
                dropdownFunction: _onDropdownSelect,
              )
            ],
          ),
        ),
      ),
    );
  }
}
