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

class MockPickImage extends Mock implements PickImage {}

void main() {
  List<XFile> imageList = [
    XFile('test1.png'),
    XFile('test2.png'),
    XFile('test3.png'),
  ];

  setUp(get_it.init);

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
          create: (_) => serviceLocator<DiaryBloc>(),
          child: BlocBuilder<DiaryBloc, DiaryState>(
            builder: (context, state) {
              if (state is RemoveImageSuccess) {
                imageList = state.updatedImageList;
              }

              return ImageListWidget(
                imageList: imageList,
                onRemoveImage: (index) {
                  BlocProvider.of<DiaryBloc>(context).add(
                    RemoveImageEvent(
                      index: index,
                      imageList: imageList,
                    ),
                  );
                },
              );
            },
          )),
    );
  }

  testWidgets('should remove picked image', (tester) async {
    final btnFinder = find.byKey(const Key('remove_image_button_1'));

    await tester.pumpWidget(widgetUnderTest());
    expect(imageList.length, 3);
    expect(find.byIcon(Icons.close), findsNWidgets(imageList.length));
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    expect(imageList.length, 2);

    expect(
      imageList.map((e) => e.path).toList(),
      [
        'test1.png',
        'test3.png',
      ],
    );

    // await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsNWidgets(imageList.length));
  });
}
