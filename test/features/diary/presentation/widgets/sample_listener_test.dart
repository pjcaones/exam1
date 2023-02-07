import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSampleBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  late DiaryBloc diaryBloc;

  setUp(() {
    diaryBloc = MockSampleBloc();
  });

  testWidgets('sample with bloclistener widget only', (tester) async {
    int a = 0;
    DiaryState? s;

    whenListen(
      diaryBloc,
      Stream.fromIterable(
        [
          RemoveImageLoading(),
        ],
      ),
      initialState: DiaryInitial(),
    );

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

    expect(a, 1);
    expect(s, isA<RemoveImageLoading>());
  });

  testWidgets('sample with bloc builder widget only', (tester) async {
    int a = 0;
    DiaryState? s;

    when(() => diaryBloc.state).thenReturn(RemoveImageLoading());

    await tester.pumpWidget(
      BlocBuilder<DiaryBloc, DiaryState>(
        bloc: diaryBloc,
        builder: (context, state) {
          if (state is RemoveImageLoading) {
            a = 1;
            s = state;
          } else {
            a = 5;
            s = state;
          }
          return Container();
        },
      ),
    );

    expect(a, 1);
    expect(s, isA<RemoveImageLoading>());
  });

  testWidgets('sample listener with alert dialog', (tester) async {
    int a = 0;

    whenListen(
      diaryBloc,
      Stream.fromIterable(
        [
          RemoveImageLoading(),
        ],
      ),
      initialState: DiaryInitial(),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocListener<DiaryBloc, DiaryState>(
            bloc: diaryBloc,
            listener: (context, state) {
              if (state is RemoveImageLoading) {
                a = 1;

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
        ),
      );
    });

    await tester.pump();

    expect(a, 1);
    // expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Sample Dialog'), findsOneWidget);
  });
}
