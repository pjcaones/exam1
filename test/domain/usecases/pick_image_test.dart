import 'package:exam1/core/helpers/image_helper.dart';
import 'package:exam1/domain/usecases/pick_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImageHelper extends Mock implements ImageHelper {}

void main() {
  late MockImageHelper mockImageHelper;
  late PickImage pickImage;

  setUp(() {
    mockImageHelper = MockImageHelper();
    pickImage = PickImage(imageHelper: mockImageHelper);
  });

  test('should add image in image list', () async {
    XFile? imageResult;
    XFile image = XFile('test1.png');

    //always keep this in mind
    //Gagamitin lang si when kapag nag implement tayo ng isang mock class
    //Bawal gamitin si when kapag direct call from any class yung gagamitin.
    when(() => mockImageHelper.pickImage(source: ImageSource.gallery))
        .thenAnswer((_) async => image);

    final result = await pickImage(ImageSource.gallery);
    expect(result, Right(image));

    result.fold(
      (fail) => null,
      (xfile) => imageResult = xfile,
    );

    expect(imageResult, image);
  });
}
