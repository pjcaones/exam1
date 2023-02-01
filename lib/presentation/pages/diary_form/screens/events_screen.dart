import 'package:exam1/presentation/components/components.dart';
import 'package:flutter/material.dart';

typedef SelectEvent = void Function(int? value);

class EventsScreen extends StatelessWidget {
  final Map<int, String> events;

  final bool isLinkExistingEvent;

  final SelectEvent onSelectEvent;

  const EventsScreen(
      {super.key,
      required this.events,
      required this.isLinkExistingEvent,
      required this.onSelectEvent});

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Link to existing event?',
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdownWidget(
                        dropdownKey: 'event',
                        labelText: 'Select an event',
                        dropdownList: events,
                        onSelectDropdownItem: onSelectEvent),
                  )
                ],
              ))),
    );
  }
}
