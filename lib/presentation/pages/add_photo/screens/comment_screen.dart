import 'package:exam1/presentation/pages/add_photo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  final TextEditingController commentController;

  const CommentScreen({super.key, required this.commentController});

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
                  const CustomCardTitle(title: "Comments"),
                  const Divider(),
                  TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                        labelText: 'Comments',
                        contentPadding: EdgeInsets.symmetric(horizontal: 0)),
                  )
                ],
              ))),
    );
  }
}
