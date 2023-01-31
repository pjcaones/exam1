import 'package:exam1/presentation/components/custom_dropdown.dart';
import 'package:exam1/presentation/pages/add_photo/widgets/widgets.dart';
import 'package:flutter/material.dart';

typedef SelectAreas = void Function(int? value);
typedef SelectCategory = void Function(int? value);

class DetailsScreen extends StatelessWidget {
  final Map<int, String> areas;
  final Map<int, String> categories;

  final TextEditingController diaryDateController;
  final int areaID;
  final int categoryID;
  final TextEditingController tagsController;

  final SelectAreas onSelectAreas;
  final SelectCategory onSelectCategory;

  const DetailsScreen(
      {super.key,
      required this.areas,
      required this.categories,
      required this.diaryDateController,
      required this.areaID,
      required this.categoryID,
      required this.tagsController,
      required this.onSelectAreas,
      required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9.0),
      child: Card(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomCardTitle(title: "Details"),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextField(
                      key: const Key('diary_date'),
                      controller: diaryDateController,
                      enabled: false,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down,
                              color: Color.fromARGB(255, 154, 154, 154)),
                          suffixIconConstraints: BoxConstraints(maxHeight: 15),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0)),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 118, 118, 118)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: CustomDropdownWidget(
                      dropdownKey: 'area',
                      labelText: 'Select Area',
                      dropdownList: areas,
                      onSelectDropdownItem: onSelectAreas,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: CustomDropdownWidget(
                        dropdownKey: 'category',
                        labelText: 'Task Category',
                        dropdownList: categories,
                        onSelectDropdownItem: onSelectCategory),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextField(
                      controller: tagsController,
                      decoration: const InputDecoration(
                          labelText: 'Tags',
                          contentPadding: EdgeInsets.symmetric(horizontal: 0)),
                    ),
                  )
                ],
              ))),
    );
  }
}
