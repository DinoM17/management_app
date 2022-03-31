import 'package:flutter/material.dart';

class DropdownList extends StatelessWidget {
  final String dropdownValue;
  final dropdownFunction;
  List<String> values;
  DropdownList(
      {required this.dropdownValue,
      required this.dropdownFunction,
      required this.values,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Icon(
        Icons.arrow_drop_down,
      ),
      value: dropdownValue,
      items: values.map((String values) {
        return DropdownMenuItem(child: Text(values), value: values);
      }).toList(),
      onChanged: dropdownFunction,
    );
  }
}
