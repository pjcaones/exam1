import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  late MockDiaryBloc mockDiaryBloc;
  late GetIt di;

  di = GetIt.instance
    ..registerFactory(
      () => mockDiaryBloc,
    );

  setUp(() {
    mockDiaryBloc = MockDiaryBloc();
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
        home: BlocProvider<DiaryBloc>.value(
          value: mockDiaryBloc,
          child: const SingleChildScrollView(
            child: DiaryForm(),
          ),
        ));
  }

  testWidgets('diary form ...', (tester) async {
    when(() => mockDiaryBloc.state).thenReturn(DiaryInitial());

    await tester.pumpWidget(widgetUnderTest());
  });
}
