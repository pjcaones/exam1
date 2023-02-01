import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/domain/usecases/usecases.dart';
import 'package:exam1/injection_container.dart';
import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:exam1/injection_container.dart' as get_it;

class MockImageHelper extends Mock implements ImageHelper {}

void main() {
  XFile tImage = XFile('test1.png');
  List<XFile> _imageList = [];

  late MockImageHelper mockImageHelper;
  late AddPhotoBloc addPhotoBloc;

  late PickImage pickImageUseCase;

  setUp(() {
    get_it.init();

    mockImageHelper = MockImageHelper();
    pickImageUseCase = PickImage(imageHelper: mockImageHelper);

    addPhotoBloc = AddPhotoBloc(
      fileToBase64: serviceLocator<FileToBase64>(),
      pickImage: pickImageUseCase,
      uploadDiary: serviceLocator<UploadDiary>(),
    );
  });

  Future<void> onSelectImage() async {
    addPhotoBloc.add(
      PickImageEvent(
        imageList: _imageList,
      ),
    );
  }

  void onRemoveSelectedImage(int index) {
    _imageList.removeAt(index);
  }

  Widget widgetUnderTest() {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => addPhotoBloc,
        child: AddPhotoScreen(
            imageList: _imageList,
            includePhotoGallery: true,
            onSelectImage: onSelectImage,
            onRemoveImage: onRemoveSelectedImage),
      ),
    );
  }

  testWidgets('add photo screen ...', (tester) async {
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

    //Testing of states here..
  });

  testWidgets('should remove picked image', (tester) async {
    int indexToRemove = 1;
    _imageList = [
      XFile('test1.png'),
      XFile('test2.png'),
      XFile('test3.png'),
    ];

    await tester.pumpWidget(widgetUnderTest());
    expect(find.byIcon(Icons.close), findsNWidgets(_imageList.length));

    addPhotoBloc.add(
      RemoveImageEvent(
        index: indexToRemove,
        imageList: _imageList,
      ),
    );

    //Playing of states here..
  });
}
