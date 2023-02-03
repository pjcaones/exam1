import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef UploadDiaryForm = void Function();

class UploadDiaryWidget extends StatelessWidget {
  const UploadDiaryWidget({
    super.key,
    required this.onUploadDiaryForm,
  });
  final UploadDiaryForm onUploadDiaryForm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          key: Key(S.of(context).keyNext),
          onPressed: onUploadDiaryForm,
          child: Text(S.of(context).buttonNext),
        ),
      ),
    );
  }
}
