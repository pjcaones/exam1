import 'dart:convert';

import 'package:intl/intl.dart';

import '../../domain/entities/diary.dart';

class DiaryModel extends Diary {
  const DiaryModel({
    required String location,
    required List<String> imageList,
    required String comment,
    required int diaryDateInMillis,
    required int areaID,
    required int taskCategoryID,
    required String tags,
    required int eventID,
  }) : super(
            location: location,
            imageList: imageList,
            comment: comment,
            diaryDateInMillis: diaryDateInMillis,
            areaID: areaID,
            taskCategoryID: taskCategoryID,
            tags: tags,
            eventID: eventID);

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
        location: json['location'],
        imageList: json['image_list'],
        comment: json['comment'],
        diaryDateInMillis: DateFormat('yyyy-MM-dd')
            .parse(json['diary_date'])
            .millisecondsSinceEpoch,
        areaID: json['area_id'],
        taskCategoryID: json['task_category_id'],
        tags: json['tags'],
        eventID: json['event_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'image_list': imageList,
      'comment': comment,
      'diary_date': DateFormat('yyyy-MM-dd')
          .format(DateTime.fromMillisecondsSinceEpoch(diaryDateInMillis)),
      'area_id': areaID,
      'task_category_id': taskCategoryID,
      'tags': tags,
      'event_id': eventID
    };
  }
}
