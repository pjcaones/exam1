import 'package:exam1/generated/l10n.dart';
import 'package:exam1/src/features/diary/diary.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key, required this.commentController});
  final TextEditingController commentController;

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
              CardTitleWidget(title: S.of(context).diaryTitleComments),
              const Divider(),
              TextField(
                key: Key(S.of(context).keyComment),
                controller: commentController,
                decoration: InputDecoration(
                  labelText: S.of(context).textfieldLabelComment,
                  contentPadding: const EdgeInsets.symmetric(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
