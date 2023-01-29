import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.location_on),
          ),
          Text(location)
        ],
      ),
    );
  }
}
