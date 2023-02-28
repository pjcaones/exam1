import 'package:flutter/material.dart';

typedef SelectDropdownItem = void Function(int? value);

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    super.key,
    required this.dropdownKey,
    required this.labelText,
    required this.dropdownList,
    required this.onSelectDropdownItem,
  });
  final String labelText;
  final String dropdownKey;
  final Map<int, String> dropdownList;

  final SelectDropdownItem onSelectDropdownItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      key: Key(dropdownKey),
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color.fromARGB(255, 154, 154, 154),
      ),
      items: dropdownList
          .map((key, value) {
            return MapEntry(
              key,
              DropdownMenuItem(
                value: key,
                child: Text(value),
              ),
            );
          })
          .values
          .toList(),
      onChanged: onSelectDropdownItem,
    );
  }
}
