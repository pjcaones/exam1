import 'package:exam1/di.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

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
      body: BlocProvider(
        create: (_) => serviceLocator<DiaryBloc>(),
        child: const DiaryStatesWidget(),
      ),
    );
  }
}
