import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/bloc/diary_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPhotoBloc extends Mock implements DiaryBloc {}

void main() {
  late DiaryBloc mockDiaryBloc;

  setUp(() {
    mockDiaryBloc = MockAddPhotoBloc();
  });

  final blocState = DiaryInitialLoadSuccess(
    location: '20041075 | TAP-NS TAP-North Strathfield',
    areas: const {
      1: 'Area 1',
      2: 'Area 2',
      3: 'Area 3',
    },
    categories: const {
      1: 'Task Category 1',
      2: 'Task Category 2',
      3: 'Task Category 3',
    },
    events: const {
      1: 'Event 1',
      2: 'Event 2',
      3: 'Event 3',
    },
    diaryDate: DateTime.now().millisecondsSinceEpoch,
  );

  void setDiaryInitialMockSuccess() {
    whenListen(
      mockDiaryBloc,
      Stream.fromIterable(
        [
          DiaryInitialLoading(),
          blocState,
        ],
      ),
      initialState: DiaryInitial(),
    );
  }

  test('should return expected order of states', () {
    setDiaryInitialMockSuccess();

    mockDiaryBloc.add(DiaryInitialEvent());

    emitsInOrder([
      DiaryInitialLoading(),
      blocState,
    ]);
  });
}
