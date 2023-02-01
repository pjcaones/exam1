import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/domain/usecases/usecases.dart';
import 'package:exam1/injection_container.dart';
import 'package:exam1/injection_container.dart' as get_it;
import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

void main() {
  get_it.init();
  late MockFileToBase64 mockFileToBase64;
  late AddPhotoBloc addPhotoBloc;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();

    addPhotoBloc = AddPhotoBloc(
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
        home: BlocProvider(
          create: (_) => addPhotoBloc,
          child: const SingleChildScrollView(
            child: DiaryForm(
              imageList: [],
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

    //Playing with states here..
  });
}
