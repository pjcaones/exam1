// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uploaded_diary_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadedDiaryResultModel _$UploadedDiaryResultModelFromJson(
    Map<String, dynamic> json) {
  return _UploadedDiaryResultModel.fromJson(json);
}

/// @nodoc
mixin _$UploadedDiaryResultModel {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadedDiaryResultModelCopyWith<UploadedDiaryResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadedDiaryResultModelCopyWith<$Res> {
  factory $UploadedDiaryResultModelCopyWith(UploadedDiaryResultModel value,
          $Res Function(UploadedDiaryResultModel) then) =
      _$UploadedDiaryResultModelCopyWithImpl<$Res, UploadedDiaryResultModel>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$UploadedDiaryResultModelCopyWithImpl<$Res,
        $Val extends UploadedDiaryResultModel>
    implements $UploadedDiaryResultModelCopyWith<$Res> {
  _$UploadedDiaryResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadedDiaryResultModelCopyWith<$Res>
    implements $UploadedDiaryResultModelCopyWith<$Res> {
  factory _$$_UploadedDiaryResultModelCopyWith(
          _$_UploadedDiaryResultModel value,
          $Res Function(_$_UploadedDiaryResultModel) then) =
      __$$_UploadedDiaryResultModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$_UploadedDiaryResultModelCopyWithImpl<$Res>
    extends _$UploadedDiaryResultModelCopyWithImpl<$Res,
        _$_UploadedDiaryResultModel>
    implements _$$_UploadedDiaryResultModelCopyWith<$Res> {
  __$$_UploadedDiaryResultModelCopyWithImpl(_$_UploadedDiaryResultModel _value,
      $Res Function(_$_UploadedDiaryResultModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$_UploadedDiaryResultModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UploadedDiaryResultModel implements _UploadedDiaryResultModel {
  const _$_UploadedDiaryResultModel({required this.id});

  factory _$_UploadedDiaryResultModel.fromJson(Map<String, dynamic> json) =>
      _$$_UploadedDiaryResultModelFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'UploadedDiaryResultModel(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadedDiaryResultModel &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadedDiaryResultModelCopyWith<_$_UploadedDiaryResultModel>
      get copyWith => __$$_UploadedDiaryResultModelCopyWithImpl<
          _$_UploadedDiaryResultModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadedDiaryResultModelToJson(
      this,
    );
  }
}

abstract class _UploadedDiaryResultModel
    implements UploadedDiaryResultModel, UploadedDiaryResult {
  const factory _UploadedDiaryResultModel({required final String id}) =
      _$_UploadedDiaryResultModel;

  factory _UploadedDiaryResultModel.fromJson(Map<String, dynamic> json) =
      _$_UploadedDiaryResultModel.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_UploadedDiaryResultModelCopyWith<_$_UploadedDiaryResultModel>
      get copyWith => throw _privateConstructorUsedError;
}
