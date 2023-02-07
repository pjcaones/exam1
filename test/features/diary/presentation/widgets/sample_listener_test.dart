import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockSampleBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  final mockSampleBloc = MockSampleBloc();

  late DiaryBloc diaryBloc;

  setUp(() {
    diaryBloc = MockSampleBloc();
  });

  testWidgets('sample with bloclistener widget only', (tester) async {
    whenListen(
      diaryBloc,
      Stream.fromIterable(
        [
          RemoveImageFailed(),
        ],
      ),
      initialState: DiaryInitial(),
    );
    int a = 0;
    DiaryState? s;

    final DiaryEvent diaryEvent = RemoveImageEvent(
      index: 1,
      imageList: [
        XFile('test1.png'),
        XFile('test2.png'),
      ],
    );

    // when(
    //   () => mockSampleBloc.state,
    // ).thenReturn(RemoveImageLoading());

    await tester.pumpWidget(
      BlocListener<DiaryBloc, DiaryState>(
        bloc: diaryBloc,
        listener: (context, state) {
          if (state is RemoveImageLoading) {
            a = 1;
            s = state;
          } else {
            a = 5;
            s = state;
          }
        },
        child: Container(),
      ),
    );

    // mockSampleBloc.add(diaryEvent);

    // verify(() => diaryBloc.add(diaryEvent)).called(1);

    //! await tester.pump(); -> Test Fail
    //! await tester.pumpAndSettle(); -> Test Fail

    expect(a, 1);
    expect(s, isA<RemoveImageLoading>());
  });

  testWidgets('sample with blocbuilder widget only', (tester) async {
    int a = 0;
    DiaryState? s;

    final DiaryEvent diaryEvent = RemoveImageEvent(
      index: 1,
      imageList: [
        XFile('test1.png'),
        XFile('test2.png'),
      ],
    );

    when(
      () => mockSampleBloc.state,
    ).thenReturn(RemoveImageLoading());

    await tester.pumpWidget(
      BlocBuilder<DiaryBloc, DiaryState>(
        bloc: mockSampleBloc,
        builder: (context, state) {
          if (state is RemoveImageLoading) {
            a = 1;
            s = state;
          }

          return Container();
        },
      ),
    );

    mockSampleBloc.add(diaryEvent);

    verify(() => mockSampleBloc.add(diaryEvent)).called(1);

    print(a);
    print(s);
  });

  testWidgets('sample with bloc consumer widget only', (tester) async {
    int a = 0;
    DiaryState? s;

    final DiaryEvent diaryEvent = RemoveImageEvent(
      index: 1,
      imageList: [
        XFile('test1.png'),
        XFile('test2.png'),
      ],
    );

    when(
      () => mockSampleBloc.state,
    ).thenReturn(RemoveImageLoading());

    await tester.pumpWidget(
      BlocConsumer<DiaryBloc, DiaryState>(
        bloc: mockSampleBloc,
        builder: (context, state) {
          return Container();
        },
        listener: (context, state) {
          if (state is RemoveImageLoading) {
            a = 1;
            s = state;
          }
        },
      ),
    );

    mockSampleBloc.add(diaryEvent);

    verify(() => mockSampleBloc.add(diaryEvent)).called(1);

    print(a);
    print(s);
  });

  testWidgets('sample listener with alert dialog', (tester) async {
    when(
      () => mockSampleBloc.state,
    ).thenReturn(RemoveImageLoading());

    await tester.pumpWidget(
      BlocListener<DiaryBloc, DiaryState>(
        bloc: mockSampleBloc,
        listener: (context, state) {
          if (state is RemoveImageLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Sample Dialog'),
                  content: const Text('Just a sample Dialog'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                );
              },
            );
          }
        },
        child: Container(),
      ),
    );

    mockSampleBloc.add(
      RemoveImageEvent(
        index: 1,
        imageList: [
          XFile('test1.png'),
          XFile('test2.png'),
        ],
      ),
    );

    // expect(find.byType(AlertDialog), findsOneWidget);
    // expect(find.text('Sample Dialog'), findsOneWidget);
  });
}
