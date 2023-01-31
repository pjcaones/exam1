import 'dart:io';

import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

void main() {
  late MockFileToBase64 mockFileToBase64;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();
    registerFallbackValue(mockFileToBase64);
  });

  File tFile = File('test.png');
  List<File> tFileList = [
    File('test1.png'),
    File('test2.png'),
    File('test3.png'),
  ];

  group('Checking of image to base64 conversion', () {
    test('should return base64 images', () async {
      //when.thenAnswer -> inserting a mock result value
      when(() => mockFileToBase64.singleConversion(file: tFile))
          .thenAnswer((_) async => 'test');

      //actual calling of function to have the result
      final result = await mockFileToBase64.singleConversion(file: tFile);
      expect(result, 'test');
    });

    test('should return list of base64 images', () async {
      when(() => mockFileToBase64.listConversion(fileList: tFileList))
          .thenAnswer((_) async => ['test 1', 'test 2', 'test 3']);

      final result = await mockFileToBase64.listConversion(fileList: tFileList);

      expect(result, ['test 1', 'test 2', 'test 3']);
    });
  });

  test('just a sample test', () async {
    when(() => mockFileToBase64.sampleFunction(i: any(named: 'i')))
        .thenAnswer((_) async => '100');
    final result = await mockFileToBase64.sampleFunction(i: 100);
    expect(result, '100');
  });
}
