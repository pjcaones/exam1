import 'package:exam1/core/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImageHelper extends Mock implements ImageHelper {}

void main() {
  late MockImageHelper mockImageHelper;

  setUp(() {
    mockImageHelper = MockImageHelper();
  });

  test('should pick a sample image from image picker..', () async {
    final XFile image = XFile('test1.png');

    when(() => mockImageHelper.pickImage(source: ImageSource.gallery))
        .thenAnswer((invocation) async => image);

    final result = await mockImageHelper.pickImage(source: ImageSource.gallery);
    expect(result, image);
  });
}
