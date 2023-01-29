import 'package:flutter/material.dart';

class CustomCardTitle extends StatelessWidget {
  final String title;

  const CustomCardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }
}
