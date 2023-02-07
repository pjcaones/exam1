import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

void main() {
  late MockFileToBase64 mockFileToBase64;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();
    registerFallbackValue(mockFileToBase64);
  });

  final File tFile = File('test.png');
  final List<File> tFileList = [
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

  group('sample', () {
    final actualFile = File(
        '/Users/jpcaones/Library/Developer/CoreSimulator/Devices/EE8D9367-6B36-4497-9C67-E7A299A373A5/data/Containers/Data/Application/809DDE96-A11B-43C7-B131-4D8EF7E078BF/tmp/image_picker_58AEF2C8-4B90-4A69-B27B-9DBF3C3B3CB8-16576-00000031EA461CE9.jpg');
    final fileBaseTo64 = FileToBase64();

    test('single conversion', () async {
      final encodedFile = base64.encode(actualFile.readAsBytesSync());

      final result = await fileBaseTo64.singleConversion(file: actualFile);

      expect(result, encodedFile);
    });

    test('list conversion', () async {
      final convertedList = [base64.encode(actualFile.readAsBytesSync())];
      final List<File> actualListFile = [
        actualFile,
      ];

      final result =
          await fileBaseTo64.listConversion(fileList: actualListFile);
      expect(result, convertedList);
    });
  });
}
