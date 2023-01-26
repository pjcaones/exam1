import 'package:exam1/components/custom_dropdown.dart';
import 'package:flutter/material.dart';

typedef SelectAreas = void Function(int? value);
typedef SelectCategory = void Function(int? value);

class DetailsScreen extends StatelessWidget {
  final TextEditingController diaryDateController;
  final int areaID;
  final int categoryID;
  final TextEditingController tagsController;

  final SelectAreas onSelectAreas;
  final SelectCategory onSelectCategory;

  const DetailsScreen(
      {super.key,
      required this.diaryDateController,
      required this.areaID,
      required this.categoryID,
      required this.tagsController,
      required this.onSelectAreas,
      required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    final Map<int, String> areas = {
      1: 'Area 1',
      2: 'Area 2',
      3: 'Area 3',
    };

    final Map<int, String> categories = {
      1: 'Task Category 1',
      2: 'Task Category 2',
      3: 'Task Category 3',
    };

    return Card(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: diaryDateController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 3.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomDropdownWidget(
                    labelText: 'Areas',
                    dropdownList: areas,
                    onSelectDropdownItem: onSelectAreas,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomDropdownWidget(
                      labelText: 'Task Categories',
                      dropdownList: categories,
                      onSelectDropdownItem: onSelectCategory),
                ),
                TextField(
                  controller: tagsController,
                  decoration: const InputDecoration(
                      labelText: 'Tags',
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.0)),
                )
              ],
            )));
  }
}
