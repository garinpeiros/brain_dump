import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/model/memo_with_dorama_model.dart';
import 'package:brain_dump/repository/tag_memo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/freezed/tag_model.dart';

class TagMemoDatabaseNotifier extends StateNotifier<TagMemoTlStateData> {
  TagMemoDatabaseNotifier({required LinkTagData tag})
      : super(TagMemoTlStateData()) {
    fetchMemoByTag(tag.id);
  }

  final TagMemoRepository _repository = TagMemoRepository();

  ///
  /// タグ単位でメモ情報を取得
  ///
  Future<void> fetchMemoByTag(int tagId) async {
    state = state.copyWith(isLoading: true);
    final List<MemoWithDoramaModel> items =
        await _repository.fetchMemoByTag(tagId);
    state = state.copyWith(memoItems: items, isLoading: false);
  }
}

final tagMemoDatabaseProvider = StateNotifierProvider.family
    .autoDispose<TagMemoDatabaseNotifier, TagMemoTlStateData, LinkTagData>(
  (ref, tag) => TagMemoDatabaseNotifier(tag: tag),
);
