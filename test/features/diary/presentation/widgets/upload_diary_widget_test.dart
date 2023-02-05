import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/di.dart' as get_it;
import 'package:exam1/di.dart';
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

void main() {
  get_it.init();
  late MockFileToBase64 mockFileToBase64;

  late DiaryBloc diaryBloc;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();

    diaryBloc = DiaryBloc(
      fileToBase64: mockFileToBase64,
      pickImage: serviceLocator<PickImage>(),
      uploadDiary: serviceLocator<UploadDiary>(),
    );
  });

  final List<String> tConvertedFileList = [
    'Test 1',
    'Test 2',
    'Test 3',
  ];

  testWidgets('diary form ...', (tester) async {
    final btnFinder = find.byKey(const Key('next'));

    when(() => mockFileToBase64.listConversion(
          fileList: any(named: 'fileList'),
        )).thenAnswer((_) async => tConvertedFileList);

    await tester.pumpWidget(
      MaterialApp(
        title: 'Exam 1',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider(
          create: (_) => diaryBloc,
          child: BlocListener<DiaryBloc, DiaryState>(
            listener: (context, state) {},
            child: const SingleChildScrollView(
              child: DiaryForm(),
            ),
          ),
        ),
      ),
    );

    await tester.ensureVisible(btnFinder);
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    await untilCalled(
      () => mockFileToBase64.listConversion(
        fileList: any(named: 'fileList'),
      ),
    );

    verify(
      () => mockFileToBase64.listConversion(
        fileList: any(named: 'fileList'),
      ),
    );

    await tester.pumpAndSettle();
    // print(addPhotoBloc.state);
  });
}
