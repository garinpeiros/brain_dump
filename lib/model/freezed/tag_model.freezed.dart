// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TempTagDataTearOff {
  const _$TempTagDataTearOff();

  _TempTagData call({dynamic title = ''}) {
    return _TempTagData(
      title: title,
    );
  }
}

/// @nodoc
const $TempTagData = _$TempTagDataTearOff();

/// @nodoc
mixin _$TempTagData {
  dynamic get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempTagDataCopyWith<TempTagData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempTagDataCopyWith<$Res> {
  factory $TempTagDataCopyWith(
          TempTagData value, $Res Function(TempTagData) then) =
      _$TempTagDataCopyWithImpl<$Res>;
  $Res call({dynamic title});
}

/// @nodoc
class _$TempTagDataCopyWithImpl<$Res> implements $TempTagDataCopyWith<$Res> {
  _$TempTagDataCopyWithImpl(this._value, this._then);

  final TempTagData _value;
  // ignore: unused_field
  final $Res Function(TempTagData) _then;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$TempTagDataCopyWith<$Res>
    implements $TempTagDataCopyWith<$Res> {
  factory _$TempTagDataCopyWith(
          _TempTagData value, $Res Function(_TempTagData) then) =
      __$TempTagDataCopyWithImpl<$Res>;
  @override
  $Res call({dynamic title});
}

/// @nodoc
class __$TempTagDataCopyWithImpl<$Res> extends _$TempTagDataCopyWithImpl<$Res>
    implements _$TempTagDataCopyWith<$Res> {
  __$TempTagDataCopyWithImpl(
      _TempTagData _value, $Res Function(_TempTagData) _then)
      : super(_value, (v) => _then(v as _TempTagData));

  @override
  _TempTagData get _value => super._value as _TempTagData;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_TempTagData(
      title: title == freezed ? _value.title : title,
    ));
  }
}

/// @nodoc

class _$_TempTagData implements _TempTagData {
  _$_TempTagData({this.title = ''});

  @JsonKey()
  @override
  final dynamic title;

  @override
  String toString() {
    return 'TempTagData(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TempTagData &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$TempTagDataCopyWith<_TempTagData> get copyWith =>
      __$TempTagDataCopyWithImpl<_TempTagData>(this, _$identity);
}

abstract class _TempTagData implements TempTagData {
  factory _TempTagData({dynamic title}) = _$_TempTagData;

  @override
  dynamic get title;
  @override
  @JsonKey(ignore: true)
  _$TempTagDataCopyWith<_TempTagData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$TagTlStateDataTearOff {
  const _$TagTlStateDataTearOff();

  _TagTlStateData call(
      {bool isLoading = false,
      bool isReadyData = true,
      bool hasNext = true,
      List<TagWithCountModel> tagItems = const []}) {
    return _TagTlStateData(
      isLoading: isLoading,
      isReadyData: isReadyData,
      hasNext: hasNext,
      tagItems: tagItems,
    );
  }
}

/// @nodoc
const $TagTlStateData = _$TagTlStateDataTearOff();

/// @nodoc
mixin _$TagTlStateData {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isReadyData => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<TagWithCountModel> get tagItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagTlStateDataCopyWith<TagTlStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagTlStateDataCopyWith<$Res> {
  factory $TagTlStateDataCopyWith(
          TagTlStateData value, $Res Function(TagTlStateData) then) =
      _$TagTlStateDataCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<TagWithCountModel> tagItems});
}

/// @nodoc
class _$TagTlStateDataCopyWithImpl<$Res>
    implements $TagTlStateDataCopyWith<$Res> {
  _$TagTlStateDataCopyWithImpl(this._value, this._then);

  final TagTlStateData _value;
  // ignore: unused_field
  final $Res Function(TagTlStateData) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReadyData = freezed,
    Object? hasNext = freezed,
    Object? tagItems = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadyData: isReadyData == freezed
          ? _value.isReadyData
          : isReadyData // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      tagItems: tagItems == freezed
          ? _value.tagItems
          : tagItems // ignore: cast_nullable_to_non_nullable
              as List<TagWithCountModel>,
    ));
  }
}

/// @nodoc
abstract class _$TagTlStateDataCopyWith<$Res>
    implements $TagTlStateDataCopyWith<$Res> {
  factory _$TagTlStateDataCopyWith(
          _TagTlStateData value, $Res Function(_TagTlStateData) then) =
      __$TagTlStateDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<TagWithCountModel> tagItems});
}

/// @nodoc
class __$TagTlStateDataCopyWithImpl<$Res>
    extends _$TagTlStateDataCopyWithImpl<$Res>
    implements _$TagTlStateDataCopyWith<$Res> {
  __$TagTlStateDataCopyWithImpl(
      _TagTlStateData _value, $Res Function(_TagTlStateData) _then)
      : super(_value, (v) => _then(v as _TagTlStateData));

  @override
  _TagTlStateData get _value => super._value as _TagTlStateData;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReadyData = freezed,
    Object? hasNext = freezed,
    Object? tagItems = freezed,
  }) {
    return _then(_TagTlStateData(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadyData: isReadyData == freezed
          ? _value.isReadyData
          : isReadyData // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      tagItems: tagItems == freezed
          ? _value.tagItems
          : tagItems // ignore: cast_nullable_to_non_nullable
              as List<TagWithCountModel>,
    ));
  }
}

/// @nodoc

class _$_TagTlStateData implements _TagTlStateData {
  _$_TagTlStateData(
      {this.isLoading = false,
      this.isReadyData = true,
      this.hasNext = true,
      this.tagItems = const []});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isReadyData;
  @JsonKey()
  @override
  final bool hasNext;
  @JsonKey()
  @override
  final List<TagWithCountModel> tagItems;

  @override
  String toString() {
    return 'TagTlStateData(isLoading: $isLoading, isReadyData: $isReadyData, hasNext: $hasNext, tagItems: $tagItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagTlStateData &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isReadyData, isReadyData) &&
            const DeepCollectionEquality().equals(other.hasNext, hasNext) &&
            const DeepCollectionEquality().equals(other.tagItems, tagItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isReadyData),
      const DeepCollectionEquality().hash(hasNext),
      const DeepCollectionEquality().hash(tagItems));

  @JsonKey(ignore: true)
  @override
  _$TagTlStateDataCopyWith<_TagTlStateData> get copyWith =>
      __$TagTlStateDataCopyWithImpl<_TagTlStateData>(this, _$identity);
}

abstract class _TagTlStateData implements TagTlStateData {
  factory _TagTlStateData(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<TagWithCountModel> tagItems}) = _$_TagTlStateData;

  @override
  bool get isLoading;
  @override
  bool get isReadyData;
  @override
  bool get hasNext;
  @override
  List<TagWithCountModel> get tagItems;
  @override
  @JsonKey(ignore: true)
  _$TagTlStateDataCopyWith<_TagTlStateData> get copyWith =>
      throw _privateConstructorUsedError;
}
