import 'package:exam1/components/custom_dropdown.dart';
import 'package:flutter/material.dart';

typedef SelectEvent = void Function(int? value);

class EventsScreen extends StatelessWidget {
  final bool isLinkExistingEvent;

  final SelectEvent onSelectEvent;

  const EventsScreen(
      {super.key,
      required this.isLinkExistingEvent,
      required this.onSelectEvent});

  @override
  Widget build(BuildContext context) {
    final Map<int, String> events = {1: 'Event 1', 2: 'Event 2', 3: 'Event 3'};

    return Card(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Link to existing event?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdownWidget(
                      labelText: 'Select an event',
                      dropdownList: events,
                      onSelectDropdownItem: onSelectEvent),
                )
              ],
            )));
  }
}
