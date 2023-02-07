import 'dart:convert';
import 'dart:io';

class FileToBase64 {
  Future<String> singleConversion({required File file}) async {
    final bytes = file.readAsBytesSync();

    return base64.encode(bytes);
  }

  Future<List<String>> listConversion({required List<File> fileList}) async {
    final List<String> convertedList = [];

    for (final File file in fileList) {
      convertedList.add(await singleConversion(file: file));
    }

    return convertedList;
  }
}
