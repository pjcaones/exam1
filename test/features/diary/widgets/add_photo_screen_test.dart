import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';

import 'package:exam1/generated/l10n.dart';
import 'package:exam1/src/features/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MockPickImage extends Mock implements PickImage {}

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  final XFile tImage = XFile('test1.png');
  List<XFile> imageList = [];

  late MockDiaryBloc mockDiaryBloc;

  setUp(() {
    mockDiaryBloc = MockDiaryBloc();
  });

  final btnFinder = find.byKey(const Key('add_photo'));
  Widget widgetUnderTest({WidgetTester? tester}) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: BlocProvider<DiaryBloc>.value(
        value: mockDiaryBloc,
        child: BlocListener<DiaryBloc, DiaryState>(
          listener: (context, state) {
            if (state is PickImageLoading) {
              ProgressDialog(
                tester!.element(btnFinder),
                type: ProgressDialogType.normal,
                isDismissible: false,
              ).show();
            }
          },
          child: BlocBuilder<DiaryBloc, DiaryState>(
            builder: (context, state) {
              if (state is PickImageSuccess) {
                imageList = state.updatedImageList;
              }

              return AddPhotoScreen(
                imageList: imageList,
                includePhotoGallery: true,
                onIncludePhotoGallery: (value) => true,
                onSelectImage: () {
                  context.read<DiaryBloc>().add(
                        PickImageEvent(
                          imageList: imageList,
                        ),
                      );
                },
                onRemoveImage: (index) {
                  // TODO: nothing todo here tbh
                },
              );
            },
          ),
        ),
      ),
    );
  }

  group('with mock bloc', () {
    List<XFile> tUpdatedImageList = [];

    testWidgets('should add photo when success', (tester) async {
      tUpdatedImageList = [
        tImage,
      ];

      when(() => mockDiaryBloc.state).thenReturn(PickImageSuccess(
        updatedImageList: tUpdatedImageList,
      ));

      await tester.pumpWidget(widgetUnderTest());
      expect(btnFinder, findsOneWidget);

      await tester.tap(btnFinder);
      await tester.pumpAndSettle();

      verify(
        () => mockDiaryBloc.add(
          PickImageEvent(
            imageList: imageList,
          ),
        ),
      ).called(1);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should not add photo when failed', (tester) async {
      when(() => mockDiaryBloc.state).thenReturn(PickImageFailed());

      await tester.pumpWidget(widgetUnderTest());
      expect(btnFinder, findsOneWidget);

      await tester.tap(btnFinder);
      await tester.pumpAndSettle();

      verify(
        () => mockDiaryBloc.add(
          PickImageEvent(
            imageList: imageList,
          ),
        ),
      ).called(1);

      expect(find.byType(Image), findsNWidgets(imageList.length));
    });
  });
}
