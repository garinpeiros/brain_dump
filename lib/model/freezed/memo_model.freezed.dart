// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'memo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MemoStateDataTearOff {
  const _$MemoStateDataTearOff();

  _MemoStateData call(
      {bool isLoading = false,
      bool isReady = true,
      bool hasNext = true,
      List<MemoData> memoItems = const []}) {
    return _MemoStateData(
      isLoading: isLoading,
      isReady: isReady,
      hasNext: hasNext,
      memoItems: memoItems,
    );
  }
}

/// @nodoc
const $MemoStateData = _$MemoStateDataTearOff();

/// @nodoc
mixin _$MemoStateData {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isReady => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<MemoData> get memoItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemoStateDataCopyWith<MemoStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoStateDataCopyWith<$Res> {
  factory $MemoStateDataCopyWith(
          MemoStateData value, $Res Function(MemoStateData) then) =
      _$MemoStateDataCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading, bool isReady, bool hasNext, List<MemoData> memoItems});
}

/// @nodoc
class _$MemoStateDataCopyWithImpl<$Res>
    implements $MemoStateDataCopyWith<$Res> {
  _$MemoStateDataCopyWithImpl(this._value, this._then);

  final MemoStateData _value;
  // ignore: unused_field
  final $Res Function(MemoStateData) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReady = freezed,
    Object? hasNext = freezed,
    Object? memoItems = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isReady: isReady == freezed
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      memoItems: memoItems == freezed
          ? _value.memoItems
          : memoItems // ignore: cast_nullable_to_non_nullable
              as List<MemoData>,
    ));
  }
}

/// @nodoc
abstract class _$MemoStateDataCopyWith<$Res>
    implements $MemoStateDataCopyWith<$Res> {
  factory _$MemoStateDataCopyWith(
          _MemoStateData value, $Res Function(_MemoStateData) then) =
      __$MemoStateDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading, bool isReady, bool hasNext, List<MemoData> memoItems});
}

/// @nodoc
class __$MemoStateDataCopyWithImpl<$Res>
    extends _$MemoStateDataCopyWithImpl<$Res>
    implements _$MemoStateDataCopyWith<$Res> {
  __$MemoStateDataCopyWithImpl(
      _MemoStateData _value, $Res Function(_MemoStateData) _then)
      : super(_value, (v) => _then(v as _MemoStateData));

  @override
  _MemoStateData get _value => super._value as _MemoStateData;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReady = freezed,
    Object? hasNext = freezed,
    Object? memoItems = freezed,
  }) {
    return _then(_MemoStateData(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isReady: isReady == freezed
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      memoItems: memoItems == freezed
          ? _value.memoItems
          : memoItems // ignore: cast_nullable_to_non_nullable
              as List<MemoData>,
    ));
  }
}

/// @nodoc

class _$_MemoStateData implements _MemoStateData {
  _$_MemoStateData(
      {this.isLoading = false,
      this.isReady = true,
      this.hasNext = true,
      this.memoItems = const []});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isReady;
  @JsonKey()
  @override
  final bool hasNext;
  @JsonKey()
  @override
  final List<MemoData> memoItems;

  @override
  String toString() {
    return 'MemoStateData(isLoading: $isLoading, isReady: $isReady, hasNext: $hasNext, memoItems: $memoItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MemoStateData &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isReady, isReady) &&
            const DeepCollectionEquality().equals(other.hasNext, hasNext) &&
            const DeepCollectionEquality().equals(other.memoItems, memoItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isReady),
      const DeepCollectionEquality().hash(hasNext),
      const DeepCollectionEquality().hash(memoItems));

  @JsonKey(ignore: true)
  @override
  _$MemoStateDataCopyWith<_MemoStateData> get copyWith =>
      __$MemoStateDataCopyWithImpl<_MemoStateData>(this, _$identity);
}

abstract class _MemoStateData implements MemoStateData {
  factory _MemoStateData(
      {bool isLoading,
      bool isReady,
      bool hasNext,
      List<MemoData> memoItems}) = _$_MemoStateData;

  @override
  bool get isLoading;
  @override
  bool get isReady;
  @override
  bool get hasNext;
  @override
  List<MemoData> get memoItems;
  @override
  @JsonKey(ignore: true)
  _$MemoStateDataCopyWith<_MemoStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$TempMemoDataTearOff {
  const _$TempMemoDataTearOff();

  _TempMemoData call(
      {String title = '', String content = '', int categoryId = 0}) {
    return _TempMemoData(
      title: title,
      content: content,
      categoryId: categoryId,
    );
  }
}

/// @nodoc
const $TempMemoData = _$TempMemoDataTearOff();

/// @nodoc
mixin _$TempMemoData {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempMemoDataCopyWith<TempMemoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempMemoDataCopyWith<$Res> {
  factory $TempMemoDataCopyWith(
          TempMemoData value, $Res Function(TempMemoData) then) =
      _$TempMemoDataCopyWithImpl<$Res>;
  $Res call({String title, String content, int categoryId});
}

/// @nodoc
class _$TempMemoDataCopyWithImpl<$Res> implements $TempMemoDataCopyWith<$Res> {
  _$TempMemoDataCopyWithImpl(this._value, this._then);

  final TempMemoData _value;
  // ignore: unused_field
  final $Res Function(TempMemoData) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? content = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$TempMemoDataCopyWith<$Res>
    implements $TempMemoDataCopyWith<$Res> {
  factory _$TempMemoDataCopyWith(
          _TempMemoData value, $Res Function(_TempMemoData) then) =
      __$TempMemoDataCopyWithImpl<$Res>;
  @override
  $Res call({String title, String content, int categoryId});
}

/// @nodoc
class __$TempMemoDataCopyWithImpl<$Res> extends _$TempMemoDataCopyWithImpl<$Res>
    implements _$TempMemoDataCopyWith<$Res> {
  __$TempMemoDataCopyWithImpl(
      _TempMemoData _value, $Res Function(_TempMemoData) _then)
      : super(_value, (v) => _then(v as _TempMemoData));

  @override
  _TempMemoData get _value => super._value as _TempMemoData;

  @override
  $Res call({
    Object? title = freezed,
    Object? content = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_TempMemoData(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TempMemoData implements _TempMemoData {
  _$_TempMemoData({this.title = '', this.content = '', this.categoryId = 0});

  @JsonKey()
  @override
  final String title;
  @JsonKey()
  @override
  final String content;
  @JsonKey()
  @override
  final int categoryId;

  @override
  String toString() {
    return 'TempMemoData(title: $title, content: $content, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TempMemoData &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(categoryId));

  @JsonKey(ignore: true)
  @override
  _$TempMemoDataCopyWith<_TempMemoData> get copyWith =>
      __$TempMemoDataCopyWithImpl<_TempMemoData>(this, _$identity);
}

abstract class _TempMemoData implements TempMemoData {
  factory _TempMemoData({String title, String content, int categoryId}) =
      _$_TempMemoData;

  @override
  String get title;
  @override
  String get content;
  @override
  int get categoryId;
  @override
  @JsonKey(ignore: true)
  _$TempMemoDataCopyWith<_TempMemoData> get copyWith =>
      throw _privateConstructorUsedError;
}
