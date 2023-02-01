import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Icons.location_on),
          ),
          Expanded(
            child: Text(location),
          )
        ],
      ),
    );
  }
}
