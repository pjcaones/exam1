// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryModel _$$_DiaryModelFromJson(Map<String, dynamic> json) =>
    _$_DiaryModel(
      location: json['location'] as String,
      imageList:
          (json['imageList'] as List<dynamic>).map((e) => e as String).toList(),
      comment: json['comment'] as String,
      diaryDateInMillis: json['diaryDateInMillis'] as int,
      areaID: json['areaID'] as int,
      taskCategoryID: json['taskCategoryID'] as int,
      tags: json['tags'] as String,
      eventID: json['eventID'] as int,
    );

Map<String, dynamic> _$$_DiaryModelToJson(_$_DiaryModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'imageList': instance.imageList,
      'comment': instance.comment,
      'diaryDateInMillis': instance.diaryDateInMillis,
      'areaID': instance.areaID,
      'taskCategoryID': instance.taskCategoryID,
      'tags': instance.tags,
      'eventID': instance.eventID,
    };
