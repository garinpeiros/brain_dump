import 'package:brain_dump/model/db/db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../memo_with_dorama_model.dart';
import '../tag_with_count_model.dart';

part 'tag_model.freezed.dart';

@freezed
abstract class TempTagData with _$TempTagData {
  factory TempTagData({
    @Default('') title,
  }) = _TempTagData;
}

@freezed
abstract class TagTlStateData with _$TagTlStateData {
  factory TagTlStateData({
    @Default(false) bool isLoading,
    @Default(true) bool isReadyData,
    @Default(true) bool hasNext,
    @Default([]) List<TagWithCountModel> tagItems,
  }) = _TagTlStateData;
}

@freezed
abstract class TagMemoTlStateData with _$TagMemoTlStateData {
  factory TagMemoTlStateData({
    @Default(false) bool isLoading,
    @Default([]) List<MemoWithDoramaModel> memoItems,
  }) = _TagMemoTlStateData;
}

@freezed
abstract class MemoTagStateData with _$MemoTagStateData {
  factory MemoTagStateData({
    @Default(false) bool isLoading,
    @Default([]) List<LinkTagData> tagItems,
  }) = _MemoTagStateData;
}
