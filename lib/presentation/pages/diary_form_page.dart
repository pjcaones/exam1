import 'package:exam1/injection_container.dart';
import 'package:exam1/presentation/helpers/image_helper.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:exam1/presentation/pages/add_photo/forms/diary_form.dart';
import 'package:exam1/presentation/pages/add_photo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class DiaryFormPage extends StatelessWidget {
  const DiaryFormPage({super.key});

  void diaryDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function() onPressed}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
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
        title: const Text('New Diary'),
        centerTitle: false,
        leadingWidth: 30.0,
        leading: IconButton(
          icon: const Icon(Icons.close_sharp),
          padding: const EdgeInsets.only(left: 12.0),
          onPressed: () {
            //Prompt for confirming closing the app
          },
        ),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<AddPhotoBloc>(),
        child: BlocConsumer<AddPhotoBloc, AddPhotoState>(
          listener: (context, state) {
            ProgressDialog progressDialog = ProgressDialog(context,
                type: ProgressDialogType.normal, isDismissible: false);

            if (state is UploadDiaryLoading) {
              if (!progressDialog.isShowing()) {
                progressDialog.show();
              }
            } else if (state is UploadDiaryFailed) {
              if (progressDialog.isShowing()) {
                progressDialog.hide();

                diaryDialog(
                    context: context,
                    title: 'Upload Failed',
                    message: state.errorMessage ?? 'Something went wrong..',
                    onPressed: () {
                      Navigator.of(context).pop();
                    });
              }
            } else if (state is UploadDiarySuccess) {
              if (progressDialog.isShowing()) {
                progressDialog.hide();

                diaryDialog(
                    context: context,
                    title: 'Upload Success',
                    message: 'Your diary has beed uploaded!',
                    onPressed: () {
                      Navigator.of(context).pop();
                    });
              }
            }
          },
          builder: (context, state) {
            return const SingleChildScrollView(
              child: DiaryForm(),
            );
          },
        ),
      ),
    );
  }
}
