import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef SelectEvent = void Function(int? value);

class EventsScreen extends StatelessWidget {
  const EventsScreen(
      {super.key,
      required this.events,
      required this.isLinkExistingEvent,
      required this.onSelectEvent});
  final Map<int, String> events;

  final bool isLinkExistingEvent;

  final SelectEvent onSelectEvent;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).diaryTitleEvent,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Checkbox(
                              value: true,
                              onChanged: (val) {},
                            ))
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomDropdownWidget(
                        dropdownKey: S.of(context).keyEvent,
                        labelText: S.of(context).textfieldLabelEvent,
                        dropdownList: events,
                        onSelectDropdownItem: onSelectEvent),
                  )
                ],
              ))),
    );
  }
}
