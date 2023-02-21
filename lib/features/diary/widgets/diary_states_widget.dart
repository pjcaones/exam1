import 'package:exam1/features/diary/bloc/diary_bloc.dart';

import 'package:exam1/features/diary/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class DiaryStatesWidget extends StatelessWidget {
  const DiaryStatesWidget({
    super.key,
    this.isTestMode = false,
    this.testImageList,
  });

  final bool isTestMode;
  final List<XFile>? testImageList;

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
        final ProgressDialog progressDialog = ProgressDialog(
          context,
          type: ProgressDialogType.normal,
          isDismissible: false,
        );

        if (progressDialog.isShowing()) {
          progressDialog.hide();
        }

        if (state is UploadDiaryLoading ||
            state is PickImageLoading ||
            state is DiaryInitialEvent) {
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
      child: SingleChildScrollView(
        child: DiaryForm(
          imageList: isTestMode ? testImageList : null,
        ),
      ),
    );
  }
}
