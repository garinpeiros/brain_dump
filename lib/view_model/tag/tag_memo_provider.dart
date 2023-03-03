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

  /*
  ///
  /// 更新
  ///
  Future<void> update(MemoData data) async {
    state = state.copyWith(isLoading: true);
    await _memoRepository.update(data);
    List<MemoWithDoramaModel> items = state.memoItems;
    int index = items.indexWhere((element) => element.memo.id == data.id);
    items[index] = MemoWithDoramaModel(data, items[index].dorama);
    state = state.copyWith(isLoading: false, memoItems: items);
  }

  ///
  /// 削除
  ///
  Future<void> delete(MemoWithDoramaModel data) async {
    await _memoRepository.delete(data.memo.id);
    state = state.copyWith(isLoading: true);
    List<MemoWithDoramaModel> items = state.memoItems;
    items.removeWhere((element) => element.memo.id == data.memo.id);
    state = state.copyWith(isLoading: false, memoItems: items);
  }
   */
}

final tagMemoDatabaseProvider = StateNotifierProvider.family
    .autoDispose<TagMemoDatabaseNotifier, TagMemoTlStateData, LinkTagData>(
  (ref, tag) => TagMemoDatabaseNotifier(tag: tag),
);
