import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class DiaryStatesWidget extends StatelessWidget {
  const DiaryStatesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> diaryDialog(
        {required String title,
        required String message,
        required void Function() onPressed}) async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: onPressed,
                child: Text(S.of(context).buttonOK),
              )
            ],
          );
        },
      );
    }

    return BlocListener<DiaryBloc, DiaryState>(
      listener: (context, state) {
        final ProgressDialog progressDialog = ProgressDialog(context,
            type: ProgressDialogType.normal, isDismissible: false);

        if (progressDialog.isShowing()) {
          progressDialog.hide();
        }

        if (state is UploadDiaryLoading || state is PickImageLoading) {
          if (!progressDialog.isShowing()) {
            progressDialog.show();
          }
        } else if (state is UploadDiaryFailed) {
          diaryDialog(
              title: S.of(context).uploadFailed,
              message: state.errorMessage ?? S.of(context).errorMessageDefault,
              onPressed: () {
                Navigator.of(context).pop();
              });
        } else if (state is UploadDiarySuccess) {
          diaryDialog(
              title: S.of(context).uploadSuccess,
              message: S.of(context).uploadDiarySuccessMessage,
              onPressed: () {
                Navigator.of(context).pop();
              });
        }
      },
      child: const SingleChildScrollView(
        child: DiaryForm(),
      ),
    );
  }
}
