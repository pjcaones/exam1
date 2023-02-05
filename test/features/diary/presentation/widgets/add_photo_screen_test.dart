import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/di.dart' as get_it;
import 'package:exam1/di.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockPickImage extends Mock implements PickImage {}

void main() {
  final XFile tImage = XFile('test1.png');
  List<XFile> imageList = [];

  late DiaryBloc diaryBloc;

  late MockPickImage pickImageUseCase;

  setUp(() {
    pickImageUseCase = MockPickImage();

    diaryBloc = DiaryBloc(
      fileToBase64: serviceLocator<FileToBase64>(),
      pickImage: pickImageUseCase,
      uploadDiary: serviceLocator<UploadDiary>(),
    );
  });

  Widget widgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: BlocProvider(
        create: (context) => diaryBloc,
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
                  diaryBloc.add(
                    PickImageEvent(
                      imageList: imageList,
                    ),
                  );
                },
                onRemoveImage: (index) {});
          },
        ),
      ),
    );
  }

  get_it.init();

  testWidgets('should add photo when success', (tester) async {
    final btnFinder = find.byKey(const Key('add_photo'));
    const ImageDetails tImageDetails = ImageDetails(
      imageSource: ImageSource.gallery,
    );

    when(() => pickImageUseCase(tImageDetails))
        .thenAnswer((_) async => Right(tImage));

    await tester.pumpWidget(widgetUnderTest());
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    await untilCalled(
      () => pickImageUseCase(tImageDetails),
    );

    verify(
      () => pickImageUseCase(tImageDetails),
    );

    // print(addPhotoBloc.state);
    // print(imageList.length);
  });

  testWidgets('should be as is when failed', (tester) async {
    final btnFinder = find.byKey(const Key('add_photo'));
    const ImageDetails tImageDetails = ImageDetails(
      imageSource: ImageSource.gallery,
    );

    when(() => pickImageUseCase(tImageDetails))
        .thenAnswer((_) async => Left(PickImageFailure()));

    await tester.pumpWidget(widgetUnderTest());
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    await untilCalled(
      () => pickImageUseCase(tImageDetails),
    );

    verify(
      () => pickImageUseCase(tImageDetails),
    );

    // print(addPhotoBloc.state);
    // print(imageList.length);
  });
}
