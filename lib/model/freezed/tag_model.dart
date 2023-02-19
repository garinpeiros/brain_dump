import 'package:freezed_annotation/freezed_annotation.dart';

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
