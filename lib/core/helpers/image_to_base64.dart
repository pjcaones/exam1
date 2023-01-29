import 'dart:convert';
import 'dart:io';

class FileToBase64 {
  Future<String> singleConversion({required File file}) async {
    var bytes = file.readAsBytesSync();

    return base64.encode(bytes);
  }

  Future<List<String>> listConversion({required List<File> fileList}) async {
    late List<String> convertedList = [];

    for (File file in fileList) {
      convertedList.add(await singleConversion(file: file));
    }

    return convertedList;
  }

  Future<String> sampleFunction({required int i}) async {
    return i.toString();
  }
}
