import 'package:exam1/generated/l10n.dart';
import 'package:exam1/src/features/diary/diary.dart';
import 'package:flutter/material.dart';

typedef SelectAreas = void Function(int? value);
typedef SelectCategory = void Function(int? value);

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.areas,
    required this.categories,
    required this.diaryDateController,
    required this.areaID,
    required this.categoryID,
    required this.tagsController,
    required this.onSelectAreas,
    required this.onSelectCategory,
  });
  final Map<int, String> areas;
  final Map<int, String> categories;

  final TextEditingController diaryDateController;
  final int areaID;
  final int categoryID;
  final TextEditingController tagsController;

  final SelectAreas onSelectAreas;
  final SelectCategory onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitleWidget(title: S.of(context).diaryTitleDetails),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  key: Key(S.of(context).keyDiaryDate),
                  controller: diaryDateController,
                  enabled: false,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromARGB(255, 154, 154, 154),
                    ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 15),
                    contentPadding: EdgeInsets.symmetric(),
                  ),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 118, 118, 118),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomDropdownWidget(
                  dropdownKey: S.of(context).keyArea,
                  labelText: S.of(context).textfieldLabelArea,
                  dropdownList: areas,
                  onSelectDropdownItem: onSelectAreas,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomDropdownWidget(
                  dropdownKey: S.of(context).keyCategory,
                  labelText: S.of(context).textfieldLabelCategory,
                  dropdownList: categories,
                  onSelectDropdownItem: onSelectCategory,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  key: Key(S.of(context).keyTags),
                  controller: tagsController,
                  decoration: InputDecoration(
                    labelText: S.of(context).textfieldLabelTags,
                    contentPadding: const EdgeInsets.symmetric(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
