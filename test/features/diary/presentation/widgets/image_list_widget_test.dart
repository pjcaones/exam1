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

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  List<XFile> imageList = [
    XFile('test1.png'),
    XFile('test2.png'),
    XFile('test3.png'),
  ];

  late MockDiaryBloc mockDiaryBloc;

  setUp(() {
    mockDiaryBloc = MockDiaryBloc();
  });

  final tUpdatedImageList = [
    XFile('test1.png'),
    XFile('test3.png'),
  ];

  Widget widgetUnderTest() {
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
        child: BlocBuilder<DiaryBloc, DiaryState>(
          builder: (context, state) {
            if (state is RemoveImageSuccess) {
              imageList = state.updatedImageList;
            }

            return ImageListWidget(
              imageList: imageList,
              onRemoveImage: (index) {
                context.read<DiaryBloc>().add(
                      RemoveImageEvent(
                        index: index,
                        imageList: imageList,
                      ),
                    );
              },
            );
          },
        ),
      ),
    );
  }

  group('with mock bloc', () {
    testWidgets('should return updated image list after tapping remove',
        (tester) async {
      final btnFinder = find.byKey(const Key('remove_image_button_1'));
      when(() => mockDiaryBloc.state).thenReturn(RemoveImageSuccess(
        updatedImageList: tUpdatedImageList,
      ));

      await tester.pumpWidget(widgetUnderTest());
      expect(find.byIcon(Icons.close), findsNWidgets(imageList.length));
      expect(btnFinder, findsOneWidget);

      await tester.tap(btnFinder);
      await tester.pumpAndSettle();

      verify(
        () => mockDiaryBloc.add(RemoveImageEvent(
          imageList: imageList,
          index: 1,
        )),
      ).called(1);

      expect(find.byIcon(Icons.close), findsNWidgets(tUpdatedImageList.length));
    });
  });
}
