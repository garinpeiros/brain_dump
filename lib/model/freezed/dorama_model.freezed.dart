// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dorama_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DoramaStateDataTearOff {
  const _$DoramaStateDataTearOff();

  _DoramaStateData call(
      {bool isLoading = false,
      bool isReadyData = true,
      bool hasNext = true,
      List<DoramaData> doramaItems = const []}) {
    return _DoramaStateData(
      isLoading: isLoading,
      isReadyData: isReadyData,
      hasNext: hasNext,
      doramaItems: doramaItems,
    );
  }
}

/// @nodoc
const $DoramaStateData = _$DoramaStateDataTearOff();

/// @nodoc
mixin _$DoramaStateData {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isReadyData => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<DoramaData> get doramaItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DoramaStateDataCopyWith<DoramaStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoramaStateDataCopyWith<$Res> {
  factory $DoramaStateDataCopyWith(
          DoramaStateData value, $Res Function(DoramaStateData) then) =
      _$DoramaStateDataCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<DoramaData> doramaItems});
}

/// @nodoc
class _$DoramaStateDataCopyWithImpl<$Res>
    implements $DoramaStateDataCopyWith<$Res> {
  _$DoramaStateDataCopyWithImpl(this._value, this._then);

  final DoramaStateData _value;
  // ignore: unused_field
  final $Res Function(DoramaStateData) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReadyData = freezed,
    Object? hasNext = freezed,
    Object? doramaItems = freezed,
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
      doramaItems: doramaItems == freezed
          ? _value.doramaItems
          : doramaItems // ignore: cast_nullable_to_non_nullable
              as List<DoramaData>,
    ));
  }
}

/// @nodoc
abstract class _$DoramaStateDataCopyWith<$Res>
    implements $DoramaStateDataCopyWith<$Res> {
  factory _$DoramaStateDataCopyWith(
          _DoramaStateData value, $Res Function(_DoramaStateData) then) =
      __$DoramaStateDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<DoramaData> doramaItems});
}

/// @nodoc
class __$DoramaStateDataCopyWithImpl<$Res>
    extends _$DoramaStateDataCopyWithImpl<$Res>
    implements _$DoramaStateDataCopyWith<$Res> {
  __$DoramaStateDataCopyWithImpl(
      _DoramaStateData _value, $Res Function(_DoramaStateData) _then)
      : super(_value, (v) => _then(v as _DoramaStateData));

  @override
  _DoramaStateData get _value => super._value as _DoramaStateData;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isReadyData = freezed,
    Object? hasNext = freezed,
    Object? doramaItems = freezed,
  }) {
    return _then(_DoramaStateData(
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
      doramaItems: doramaItems == freezed
          ? _value.doramaItems
          : doramaItems // ignore: cast_nullable_to_non_nullable
              as List<DoramaData>,
    ));
  }
}

/// @nodoc

class _$_DoramaStateData implements _DoramaStateData {
  _$_DoramaStateData(
      {this.isLoading = false,
      this.isReadyData = true,
      this.hasNext = true,
      this.doramaItems = const []});

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
  final List<DoramaData> doramaItems;

  @override
  String toString() {
    return 'DoramaStateData(isLoading: $isLoading, isReadyData: $isReadyData, hasNext: $hasNext, doramaItems: $doramaItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DoramaStateData &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isReadyData, isReadyData) &&
            const DeepCollectionEquality().equals(other.hasNext, hasNext) &&
            const DeepCollectionEquality()
                .equals(other.doramaItems, doramaItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isReadyData),
      const DeepCollectionEquality().hash(hasNext),
      const DeepCollectionEquality().hash(doramaItems));

  @JsonKey(ignore: true)
  @override
  _$DoramaStateDataCopyWith<_DoramaStateData> get copyWith =>
      __$DoramaStateDataCopyWithImpl<_DoramaStateData>(this, _$identity);
}

abstract class _DoramaStateData implements DoramaStateData {
  factory _DoramaStateData(
      {bool isLoading,
      bool isReadyData,
      bool hasNext,
      List<DoramaData> doramaItems}) = _$_DoramaStateData;

  @override
  bool get isLoading;
  @override
  bool get isReadyData;
  @override
  bool get hasNext;
  @override
  List<DoramaData> get doramaItems;
  @override
  @JsonKey(ignore: true)
  _$DoramaStateDataCopyWith<_DoramaStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$TempDoramaDataTearOff {
  const _$TempDoramaDataTearOff();

  _TempDoramaData call({dynamic title = '', dynamic categoryId = 0}) {
    return _TempDoramaData(
      title: title,
      categoryId: categoryId,
    );
  }
}

/// @nodoc
const $TempDoramaData = _$TempDoramaDataTearOff();

/// @nodoc
mixin _$TempDoramaData {
  dynamic get title => throw _privateConstructorUsedError;
  dynamic get categoryId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempDoramaDataCopyWith<TempDoramaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempDoramaDataCopyWith<$Res> {
  factory $TempDoramaDataCopyWith(
          TempDoramaData value, $Res Function(TempDoramaData) then) =
      _$TempDoramaDataCopyWithImpl<$Res>;
  $Res call({dynamic title, dynamic categoryId});
}

/// @nodoc
class _$TempDoramaDataCopyWithImpl<$Res>
    implements $TempDoramaDataCopyWith<$Res> {
  _$TempDoramaDataCopyWithImpl(this._value, this._then);

  final TempDoramaData _value;
  // ignore: unused_field
  final $Res Function(TempDoramaData) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$TempDoramaDataCopyWith<$Res>
    implements $TempDoramaDataCopyWith<$Res> {
  factory _$TempDoramaDataCopyWith(
          _TempDoramaData value, $Res Function(_TempDoramaData) then) =
      __$TempDoramaDataCopyWithImpl<$Res>;
  @override
  $Res call({dynamic title, dynamic categoryId});
}

/// @nodoc
class __$TempDoramaDataCopyWithImpl<$Res>
    extends _$TempDoramaDataCopyWithImpl<$Res>
    implements _$TempDoramaDataCopyWith<$Res> {
  __$TempDoramaDataCopyWithImpl(
      _TempDoramaData _value, $Res Function(_TempDoramaData) _then)
      : super(_value, (v) => _then(v as _TempDoramaData));

  @override
  _TempDoramaData get _value => super._value as _TempDoramaData;

  @override
  $Res call({
    Object? title = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_TempDoramaData(
      title: title == freezed ? _value.title : title,
      categoryId: categoryId == freezed ? _value.categoryId : categoryId,
    ));
  }
}

/// @nodoc

class _$_TempDoramaData implements _TempDoramaData {
  _$_TempDoramaData({this.title = '', this.categoryId = 0});

  @JsonKey()
  @override
  final dynamic title;
  @JsonKey()
  @override
  final dynamic categoryId;

  @override
  String toString() {
    return 'TempDoramaData(title: $title, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TempDoramaData &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(categoryId));

  @JsonKey(ignore: true)
  @override
  _$TempDoramaDataCopyWith<_TempDoramaData> get copyWith =>
      __$TempDoramaDataCopyWithImpl<_TempDoramaData>(this, _$identity);
}

abstract class _TempDoramaData implements TempDoramaData {
  factory _TempDoramaData({dynamic title, dynamic categoryId}) =
      _$_TempDoramaData;

  @override
  dynamic get title;
  @override
  dynamic get categoryId;
  @override
  @JsonKey(ignore: true)
  _$TempDoramaDataCopyWith<_TempDoramaData> get copyWith =>
      throw _privateConstructorUsedError;
}
