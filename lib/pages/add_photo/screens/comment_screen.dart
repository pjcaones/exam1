import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  final TextEditingController commentController;

  const CommentScreen({super.key, required this.commentController});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Comments",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                const Divider(),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                      labelText: 'Comments',
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.0)),
                )
              ],
            )));
  }
}
