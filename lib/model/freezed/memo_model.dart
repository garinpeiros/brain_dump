import 'package:freezed_annotation/freezed_annotation.dart';

import '../db/db.dart';

part 'memo_model.freezed.dart';

/*
  String d_id;
  String title;
  String content;
  int c_id;
  int created_at;
  int updated_at;
  String documentId;
  Future<Dorama> dorama;
 */

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
