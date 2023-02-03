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
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImageHelper extends Mock implements ImageHelper {}

void main() {
  final XFile tImage = XFile('test1.png');
  List<XFile> imageList = [];

  late MockImageHelper mockImageHelper;
  late DiaryBloc diaryBloc;

  late PickImage pickImageUseCase;

  setUp(() {
    get_it.init();

    mockImageHelper = MockImageHelper();
    pickImageUseCase = PickImage(imageHelper: mockImageHelper);

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

  testWidgets('should add photo when success', (tester) async {
    final btnFinder = find.byKey(const Key('add_photo'));

    when(
      () => mockImageHelper.pickImage(source: ImageSource.gallery),
    ).thenAnswer((_) async => tImage);

    await tester.pumpWidget(widgetUnderTest());
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    await untilCalled(
      () => mockImageHelper.pickImage(source: ImageSource.gallery),
    );

    verify(
      () => mockImageHelper.pickImage(source: ImageSource.gallery),
    );

    // print(addPhotoBloc.state);
    // print(imageList.length);
  });
}
