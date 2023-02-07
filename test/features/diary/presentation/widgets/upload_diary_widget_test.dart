import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  final mockDiaryBloc = MockDiaryBloc();

  final btnFinder = find.byKey(const Key('next'));
  final uploadDiaryEvent = UploadDiaryEvent(
    location: 'location',
    comment: 'comment',
    diaryDate: 11111,
    imageList: [
      XFile('Test1.png'),
      XFile('Test2.png'),
      XFile('Test3.png'),
    ],
    areaID: 1,
    taskCategoryID: 1,
    tags: 'Sample Tag',
    eventID: 1,
  );

  Widget widgetUnderTest({WidgetTester? tester}) {
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

    return MaterialApp(
      title: 'Exam 1',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: BlocProvider<DiaryBloc>.value(
        value: mockDiaryBloc,
        child: Column(
          children: [
            UploadDiaryWidget(
              onUploadDiaryForm: () {
                tester!
                    .element(btnFinder)
                    .read<DiaryBloc>()
                    .add(uploadDiaryEvent);
              },
            ),
            BlocListener<DiaryBloc, DiaryState>(
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
                      message: state.errorMessage ??
                          S.of(context).errorMessageDefault,
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
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

  testWidgets('upload diary loading', (tester) async {
    when(() => mockDiaryBloc.state).thenReturn(UploadDiaryLoading());

    await tester.pumpWidget(widgetUnderTest(tester: tester));
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    verify(
      () => mockDiaryBloc.add(uploadDiaryEvent),
    ).called(1);

    // expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('upload diary success', (tester) async {
    when(() => mockDiaryBloc.state).thenReturn(UploadDiarySuccess());

    await tester.pumpWidget(widgetUnderTest(tester: tester));
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    verify(
      () => mockDiaryBloc.add(uploadDiaryEvent),
    ).called(1);

    // expect(find.text('Your diary has been uploaded!'), findsOneWidget);
  });

  testWidgets('upload diary failed', (tester) async {
    when(() => mockDiaryBloc.state).thenReturn(const UploadDiaryFailed());

    await tester.pumpWidget(widgetUnderTest(tester: tester));
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    verify(
      () => mockDiaryBloc.add(uploadDiaryEvent),
    ).called(1);

    // expect(find.text('Upload Failed'), findsOneWidget);
  });
}
