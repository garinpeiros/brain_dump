import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constant_config.dart';
import '../../model/db/db.dart';
import '../../model/freezed/tag_model.dart';
import '../../model/tag_with_count_model.dart';
import '../../repository/tag_repository.dart';

class TagDatabaseNotifier extends StateNotifier<TagTlStateData> {
  final TagRepository _repository = TagRepository();

  TagDatabaseNotifier() : super(TagTlStateData(tagItems: [])) {
    fetchData();
  }

  static const _limit = dataLimit;
  int _page = 0;

  ///
  /// データの書き込み
  ///
  write(LinkTagData data) async {
    if (data.title.isEmpty) {
      return;
    }
    LinkTagCompanion entry = LinkTagCompanion(
      title: Value(data.title),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
    state = state.copyWith(isLoading: true);
    await _repository.write(entry);
    refresh();
  }

  ///
  /// データ削除
  ///
  delete(LinkTagData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.delete(data.id);
    List<TagWithCountModel> items = state.tagItems;
    //保持リストから削除
    items.removeWhere((element) => element.tag.id == data.id);
    state = state.copyWith(isLoading: false, tagItems: items);
  }

  ///
  /// データ更新
  ///
  update(LinkTagData data) async {
    state = state.copyWith(isLoading: true);
    await _repository.update(data);
    List<TagWithCountModel> items = state.tagItems;
    int index = items.indexWhere((element) => element.tag.id == data.id);
    items[index] = TagWithCountModel(data, items[index].count);
    state = state.copyWith(isLoading: false, tagItems: items);
  }

  ///
  /// リフレッシュ
  ///
  refresh() {
    state = state.copyWith(
      tagItems: [],
      isLoading: false,
      hasNext: true,
    );
    _page = 0;
    fetchData();
  }

  ///
  /// 保持メモ件数をカウントアップ
  ///
  Future<void> countUp(int id) async {
    state = state.copyWith(isLoading: true);
    List<TagWithCountModel> items = state.tagItems;
    int index = items.indexWhere((element) => element.tag.id == id);
    items[index] = TagWithCountModel(items[index].tag, items[index].count + 1);
    state = state.copyWith(isLoading: false, tagItems: items);
  }

  ///
  /// 保持メモ件数をカウントダウン
  ///
  Future<void> countDown(int id) async {
    state = state.copyWith(isLoading: true);
    List<TagWithCountModel> items = state.tagItems;
    int index = items.indexWhere((element) => element.tag.id == id);
    items[index] = TagWithCountModel(items[index].tag, items[index].count - 1);
    state = state.copyWith(isLoading: false, tagItems: items);
  }

  ///
  /// データ取得
  ///
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final List<TagWithCountModel> items = await _repository.fetchData(
      offset: _page * _limit,
      limit: _limit,
    );
    final List<TagWithCountModel> newItems = [...state.tagItems, ...items];

    if (items.length % _limit != 0 || items.isEmpty) {
      state = state.copyWith(hasNext: false);
    }

    state = state.copyWith(
      isLoading: false,
      isReadyData: true,
      tagItems: newItems,
    );
    _page++;
  }
}

final tagDatabaseProvider =
    StateNotifierProvider((ref) => TagDatabaseNotifier());
