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

  ///
  /// タグ付けする処理
  ///
  Future<void> add(
      {required int tagId, required MemoWithDoramaModel memo}) async {
    state = state.copyWith(isLoading: true);
  }

  ///
  /// データ登録
  ///

  /*
  Future<void> write(TempMemoData data) async {
    MemoCompanion entry = MemoCompanion(
      title: Value(data.title),
      content: Value(data.content),
      categoryId: Value(data.categoryId),
      dId: Value(data.dId),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    state = state.copyWith(isLoading: true);
    await _repository.write(entry);
    state = state.copyWith(isLoading: false);
    refresh(dId: data.dId);
  }
  */

  ///
  /// データ削除
  ///

  /*
  Future<void> delete(MemoData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.delete(data.id);
    refresh(dId: data.dId);
  }
  */

  /*
  Future<void> refresh({required int dId}) async {
    fetchByDorama(dId);
  }
  */
}

final tagMemoDatabaseProvider = StateNotifierProvider.family
    .autoDispose<TagMemoDatabaseNotifier, TagMemoTlStateData, LinkTagData>(
  (ref, tag) => TagMemoDatabaseNotifier(tag: tag),
);
