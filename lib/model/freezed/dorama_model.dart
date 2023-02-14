import 'package:freezed_annotation/freezed_annotation.dart';

import '../db/db.dart';

part 'dorama_model.freezed.dart';

/*
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
 */

@freezed
abstract class DoramaStateData with _$DoramaStateData {
  factory DoramaStateData({
    @Default(false) bool isLoading,
    @Default(true) bool isReadyData,
    @Default(true) bool hasNext,
    @Default([]) List<DoramaData> doramaItems,
  }) = _DoramaStateData;
}

@freezed
abstract class TempDoramaData with _$TempDoramaData {
  factory TempDoramaData({
    @Default('') title,
    @Default(0) categoryId,
  }) = _TempDoramaData;
}
