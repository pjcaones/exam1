import 'package:exam1/di.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  Future<void> diaryDialog(
      {required BuildContext context,
      required String title,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).diaryFormPage),
        centerTitle: false,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.close_sharp),
          padding: const EdgeInsets.only(left: 12),
          onPressed: () {
            //Prompt for confirming closing the app
          },
        ),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<DiaryBloc>(),
        child: BlocConsumer<DiaryBloc, DiaryState>(
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
                  context: context,
                  title: S.of(context).uploadFailed,
                  message:
                      state.errorMessage ?? S.of(context).errorMessageDefault,
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            } else if (state is UploadDiarySuccess) {
              diaryDialog(
                  context: context,
                  title: S.of(context).uploadSuccess,
                  message: S.of(context).uploadDiarySuccessMessage,
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            List<XFile>? updatedImageList = [];

            if (state is PickImageSuccess) {
              updatedImageList = state.updatedImageList;
            } else if (state is RemoveImageSuccess) {
              updatedImageList = state.updatedImageList;
            }

            return SingleChildScrollView(
              child: DiaryForm(
                imageList: updatedImageList,
              ),
            );
          },
        ),
      ),
    );
  }
}
