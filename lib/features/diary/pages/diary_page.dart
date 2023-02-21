import 'package:exam1/features/diary/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/di.dart';
import 'package:exam1/features/diary/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({
    super.key,
    this.isTestMode = false,
    this.testImageList,
  });

  final bool isTestMode;
  final List<XFile>? testImageList;

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
          onPressed: () async {
            //Just for test of app closing
            await SystemNavigator.pop();
          },
        ),
      ),
      body: BlocProvider<DiaryBloc>.value(
        value: serviceLocator<DiaryBloc>(),
        child: DiaryStatesWidget(
          isTestMode: isTestMode,
          testImageList: isTestMode ? testImageList : null,
        ),
      ),
    );
  }
}
