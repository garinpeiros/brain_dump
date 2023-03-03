import 'package:brain_dump/model/db/db.dart';
import 'package:brain_dump/repository/tag_repository.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/freezed/tag_model.dart';
import '../../repository/memo_tag_repository.dart';

class MemoTagDatabaseNotifier extends StateNotifier<MemoTagStateData> {
  MemoTagDatabaseNotifier({required MemoData memo})
      : super(MemoTagStateData()) {
    fetchTagByMemo(memo.id);
  }

  final MemoTagRepository _repository = MemoTagRepository();

  Future<void> fetchTagByMemo(int memoId) async {
    state = state.copyWith(isLoading: true);
    List<LinkTagData> items = await _repository.fetchTagByMemo(memoId);
    state = state.copyWith(
      isLoading: false,
      tagItems: items,
    );
  }

  ///
  /// タグと関連づける
  ///
  Future<void> add({required LinkTagData tag, required int memoId}) async {
    state = state.copyWith(isLoading: true);
    LinkTagRelationCompanion data = LinkTagRelationCompanion(
      tagId: Value(tag.id),
      memoId: Value(memoId),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    List<LinkTagData> items = [];
    items = state.tagItems;
    items.add(tag);
    await _repository.add(data);
    state = state.copyWith(
      isLoading: false,
      tagItems: items,
    );
  }

  ///
  /// タグとの関連付けを解除
  ///
  Future<void> remove({required int tagId, required int memoId}) async {
    state = state.copyWith(isLoading: true);
    await _repository.remove(memoId: memoId, tagId: tagId);
    List<LinkTagData> items = state.tagItems;
    items.removeWhere((element) => element.id == tagId);
    state = state.copyWith(
      isLoading: false,
      tagItems: items,
    );
  }
}

final memoTagTagDatabaseProvider = StateNotifierProvider.family
    .autoDispose<MemoTagDatabaseNotifier, MemoTagStateData, MemoData>(
  (ref, memo) => MemoTagDatabaseNotifier(memo: memo),
);

final tagListFutureProvider = FutureProvider.autoDispose((ref) {
  final TagRepository repository = TagRepository();
  return repository.fetchAll();
});
