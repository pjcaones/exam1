// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryModel _$DiaryModelFromJson(Map<String, dynamic> json) {
  return _DiaryModel.fromJson(json);
}

/// @nodoc
mixin _$DiaryModel {
  String get location => throw _privateConstructorUsedError;
  List<String> get imageList => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  int get diaryDateInMillis => throw _privateConstructorUsedError;
  int get areaID => throw _privateConstructorUsedError;
  int get taskCategoryID => throw _privateConstructorUsedError;
  String get tags => throw _privateConstructorUsedError;
  int get eventID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryModelCopyWith<DiaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryModelCopyWith<$Res> {
  factory $DiaryModelCopyWith(
          DiaryModel value, $Res Function(DiaryModel) then) =
      _$DiaryModelCopyWithImpl<$Res, DiaryModel>;
  @useResult
  $Res call(
      {String location,
      List<String> imageList,
      String comment,
      int diaryDateInMillis,
      int areaID,
      int taskCategoryID,
      String tags,
      int eventID});
}

/// @nodoc
class _$DiaryModelCopyWithImpl<$Res, $Val extends DiaryModel>
    implements $DiaryModelCopyWith<$Res> {
  _$DiaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? imageList = null,
    Object? comment = null,
    Object? diaryDateInMillis = null,
    Object? areaID = null,
    Object? taskCategoryID = null,
    Object? tags = null,
    Object? eventID = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      imageList: null == imageList
          ? _value.imageList
          : imageList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      diaryDateInMillis: null == diaryDateInMillis
          ? _value.diaryDateInMillis
          : diaryDateInMillis // ignore: cast_nullable_to_non_nullable
              as int,
      areaID: null == areaID
          ? _value.areaID
          : areaID // ignore: cast_nullable_to_non_nullable
              as int,
      taskCategoryID: null == taskCategoryID
          ? _value.taskCategoryID
          : taskCategoryID // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      eventID: null == eventID
          ? _value.eventID
          : eventID // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiaryModelCopyWith<$Res>
    implements $DiaryModelCopyWith<$Res> {
  factory _$$_DiaryModelCopyWith(
          _$_DiaryModel value, $Res Function(_$_DiaryModel) then) =
      __$$_DiaryModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String location,
      List<String> imageList,
      String comment,
      int diaryDateInMillis,
      int areaID,
      int taskCategoryID,
      String tags,
      int eventID});
}

/// @nodoc
class __$$_DiaryModelCopyWithImpl<$Res>
    extends _$DiaryModelCopyWithImpl<$Res, _$_DiaryModel>
    implements _$$_DiaryModelCopyWith<$Res> {
  __$$_DiaryModelCopyWithImpl(
      _$_DiaryModel _value, $Res Function(_$_DiaryModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? imageList = null,
    Object? comment = null,
    Object? diaryDateInMillis = null,
    Object? areaID = null,
    Object? taskCategoryID = null,
    Object? tags = null,
    Object? eventID = null,
  }) {
    return _then(_$_DiaryModel(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      imageList: null == imageList
          ? _value._imageList
          : imageList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      diaryDateInMillis: null == diaryDateInMillis
          ? _value.diaryDateInMillis
          : diaryDateInMillis // ignore: cast_nullable_to_non_nullable
              as int,
      areaID: null == areaID
          ? _value.areaID
          : areaID // ignore: cast_nullable_to_non_nullable
              as int,
      taskCategoryID: null == taskCategoryID
          ? _value.taskCategoryID
          : taskCategoryID // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      eventID: null == eventID
          ? _value.eventID
          : eventID // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiaryModel implements _DiaryModel {
  const _$_DiaryModel(
      {required this.location,
      required final List<String> imageList,
      required this.comment,
      required this.diaryDateInMillis,
      required this.areaID,
      required this.taskCategoryID,
      required this.tags,
      required this.eventID})
      : _imageList = imageList;

  factory _$_DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$$_DiaryModelFromJson(json);

  @override
  final String location;
  final List<String> _imageList;
  @override
  List<String> get imageList {
    if (_imageList is EqualUnmodifiableListView) return _imageList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageList);
  }

  @override
  final String comment;
  @override
  final int diaryDateInMillis;
  @override
  final int areaID;
  @override
  final int taskCategoryID;
  @override
  final String tags;
  @override
  final int eventID;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiaryModelCopyWith<_$_DiaryModel> get copyWith =>
      __$$_DiaryModelCopyWithImpl<_$_DiaryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiaryModelToJson(
      this,
    );
  }
}

abstract class _DiaryModel implements DiaryModel {
  const factory _DiaryModel(
      {required final String location,
      required final List<String> imageList,
      required final String comment,
      required final int diaryDateInMillis,
      required final int areaID,
      required final int taskCategoryID,
      required final String tags,
      required final int eventID}) = _$_DiaryModel;

  factory _DiaryModel.fromJson(Map<String, dynamic> json) =
      _$_DiaryModel.fromJson;

  @override
  String get location;
  @override
  List<String> get imageList;
  @override
  String get comment;
  @override
  int get diaryDateInMillis;
  @override
  int get areaID;
  @override
  int get taskCategoryID;
  @override
  String get tags;
  @override
  int get eventID;
  @override
  @JsonKey(ignore: true)
  _$$_DiaryModelCopyWith<_$_DiaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
