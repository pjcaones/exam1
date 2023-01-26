import 'package:flutter/material.dart';

typedef SelectDropdownItem = void Function(int? value);

class CustomDropdownWidget extends StatelessWidget {
  final String labelText;
  final Map<int, String> dropdownList;

  final SelectDropdownItem onSelectDropdownItem;

  const CustomDropdownWidget(
      {super.key,
      required this.labelText,
      required this.dropdownList,
      required this.onSelectDropdownItem});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(filled: true, labelText: labelText),
      items: dropdownList
          .map((key, value) {
            return MapEntry(
                key,
                DropdownMenuItem(
                  value: key,
                  child: Text(value),
                ));
          })
          .values
          .toList(),
      onChanged: onSelectDropdownItem,
    );
  }
}
