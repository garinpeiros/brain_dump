import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../db/db.dart';

part 'memo_model.freezed.dart';

@freezed
abstract class MemoStateData with _$MemoStateData {
  factory MemoStateData({
    @Default(false) bool isLoading,
    @Default(true) bool isReady,
    @Default(true) bool hasNext,
    @Default([]) List<MemoData> memoItems,
  }) = _MemoStateData;
}

@freezed
abstract class TempMemoData with _$TempMemoData {
  factory TempMemoData({
    @Default('') String title,
    @Default('') String content,
    @Default(0) int categoryId,
    @Default(0) int dId,
  }) = _TempMemoData;
}

@freezed
abstract class MemoTlStateData with _$MemoTlStateData {
  factory MemoTlStateData({
    @Default(false) bool isLoading,
    @Default(true) bool isReady,
    @Default(true) bool hasNext,
    @Default([]) List<MemoWithDoramaModel> memoItems,
  }) = _MemoTlStateData;
}
